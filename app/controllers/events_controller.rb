class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy event_responses]
  before_action :authenticate_user!, only: %i[new edit update destroy download_events]
  helper EventsHelper

  def index
  end

  def all_events
    @events =
      if current_user.present? && current_user.admin?
        Event.all.sort_by(&:last_event_response_date).reverse
      else
        Event.approval_events
      end
    respond_to do |format|
      format.js
    end
  end

  def pending_events
    @events =
      if current_user.admin?
        Event.admin_pending_events
      elsif current_user.advisor?
        advisor_club_period(current_user).events.advisor_pending_events
      elsif current_user.president?
        president_club_period(current_user).events.president_pending_events
      elsif current_user.dean?
        current_facult_id = current_user.roles.where(role_type_id: RoleType.dean_id, status: 1).first.faculty_id
        Event.where(faculty_id: current_facult_id).dean_pending_events
      end
    @events ||= []
    respond_to do |format|
      format.js
    end
  end

  def past_events
    @events = Event.past_events
    respond_to do |format|
      format.js
    end
  end

  def club_events
    @events =
      if current_user.advisor?
        club_period = advisor_club_period(current_user)
        club_period.events.select { |event| event.event_responses.any? && event.event_responses.last.event_status_id == 2 } unless club_period.blank?
      elsif current_user.president?
        club_period = president_club_period(current_user)
        club_period.events.select { |event| event.event_responses.any? && event.event_responses.last.event_status_id == 2 } unless club_period.blank?
      end
    @events ||= []
    respond_to do |format|
      format.js
    end
  end

  def clubs_of_member_events
    @events = Event.member_club_events(current_user)
    respond_to do |format|
      format.js
    end
  end

  def event_responses
    event_responses = @event.event_responses.order('created_at DESC').order('id DESC')
    respond_to do |format|
      format.json { render json: event_responses, include: :event_status }
    end
  end

  def show
    authorize @event
    advisor_approved_reponse = @event.event_responses.where(
      event_status_id: EventStatus.advisor_approved_status_id
    ).last
    @advisor_approved_date =
      if advisor_approved_reponse.present?
        advisor_approved_reponse.created_at.strftime('%d/%m/%Y')
      else
        ''
      end
  end

  def new
    @event = Event.new
    authorize @event
    @event.datetime = params[:datetime].to_date if params[:datetime].present?
  end

  def edit; end

  def create
    @event = Event.new(event_params)
    @event.president_id = @event.club_period.president.id
    @event.advisor_id = @event.club_period.advisor.id
    @event.current_user = current_user
    authorize @event
    respond_to do |format|
      if !number_of_members_sufficient?(@event)
        format.html { redirect_to :back, notice: 'Etkinlik oluşturmak için yeterli üye yok.' }
      elsif @event.save
        # Akademik Danışman Onayı Bekleniyor
        event_response = EventResponse.create(event_id: @event.id, event_status_id: 4)
        @event.update(event_status_id: 4)
        advisor_mail = @event.club_period.try(:advisor).try(:profile).try(:email)
        unless advisor_mail.blank?
          EventMailer.approval_to_event(
            @event.club_period.advisor,
            @event
          ).deliver_now
        end
        if event_response
          format.html { redirect_to @event, notice: 'Etkinlik başarıyla oluşturuldu.' }
          format.json { render :show, status: :created, location: @event }
        else
          @event.destroy
          format.html { render :new }
          format.json { render json: @event.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @event
    @event.current_user = current_user
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Etkinlik başarıyla güncellendi.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @event
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Etkinlik başarıyla silindi.' }
      format.json { head :no_content }
    end
  end

  def download_events
    @start_time = params[:start_date].to_date unless params[:start_date].blank?
    @finish_time = params[:finish_date].to_date unless params[:finish_date].blank?
    @event_list =
      if @start_time.present? && @finish_time.present?
        Event.where('date(datetime) BETWEEN ? AND ?', @start_time, @finish_time)
      elsif @start_time.blank? && @finish_time.present?
        Event.where('date(datetime) <= ?', @finish_time)
      elsif @start_time.present? && @finish_time.blank?
        Event.where('date(datetime) >= ?', @start_time)
      else
        Event.all
      end
    @event_list = @event_list.where(club_period_id: params[:club_period_id].to_i) unless params[:club_period_id].blank?
    if params[:state] == 'onay'
      @event_list = @event_list.select { |x| x.event_responses.last.event_status_id == 2 }
    elsif params[:state] == 'wait'
      @event_list = @event_list.reject { |x| x.event_responses.last.event_status_id == 2 }
    end
    respond_to(:xlsx)
  end

  private

  def advisor_club_period(user)
    ClubPeriod.find_by(id: user.active_club_periods.select { |club_period| club_period.id if user.advisor?(club_period) })
  end

  def president_club_period(user)
    ClubPeriod.find_by(id: user.active_club_periods.select { |club_period| club_period.id if user.president?(club_period) })
  end

  def number_of_members_sufficient?(event)
    club_period = event.club_period
    club_category = club_period.club.club_category
    club_members = club_period.club_members
    club_members_count = club_members.nil? ? 0 : club_members.count - 1
    if club_category.vocational_club?
      club_members_count >= ClubCategory.lower_limits[:vocational_club]
    else
      club_members_count >= ClubCategory.lower_limits[:social_club]
    end
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.fetch(:event, {}).permit(:club_period_id, :event_category_id, :faculty_id, :title, :speakers, :datetime, :location, :content, :requirements, :image, :attachment, :is_admin_confirmation_ok, :is_advisor_confirmation_ok, :president_id, :advisor_id)
  end
end
