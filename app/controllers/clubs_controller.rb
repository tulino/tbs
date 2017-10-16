class ClubsController < ApplicationController
  include ClubsHelper

  before_action :set_club, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]

  def index
    if params[:search]
      @clubs = Club.search(params[:search]).order('name ASC')
    else
      @clubs = Club.order('name ASC').includes(:club_setting, :club_category)
      @all_members_count = ClubPeriod.all_members_count_by_club_period(@clubs.map(&:id))
      @clubs_of_current_user = current_user.present? && current_user.active_club_periods ? current_user.active_club_periods.compact.map { |club_period| club_period.club if club_period.present? } : []
    end

    # excel dökümü için sorgulama
    @clubs_for_excel = Club.all
    if params[:clup_category].present?
      @clubs_for_excel = @clubs_for_excel.where(club_category_id: params[:clup_category])
    end
    if params[:academic_period].present?
      @clubs_for_excel =   @clubs_for_excel.map { |x| x }.keep_if { |y| y.club_periods.map { |d| d }.keep_if { |z| z.academic_period_id == params[:academic_period] } }
    end
    if params[:state].present?
      if params[:state] == 'true'
        @clubs_for_excel = @clubs_for_excel.select { |x| x.club_setting.is_active }
      elsif params[:state] == 'false'
        @clubs_for_excel = @clubs_for_excel.select { |x| !x.club_setting.is_active }
      end
    end
    respond_to(:html, :xlsx)
    authorize @clubs
  end

  def show
    @club_period = @club.active_club_period
    @role =
      if user_signed_in? && current_user.member?(@club_period)
        current_user.roles.find_by(club_period_id: @club_period.id)
      else
        Role.new
      end
    @club_view = @club.club_setting.is_active
    @club_view_contact = @club.club_contact.present?
    if @club_period.present?
      @club_advisor = @club_period.try(:advisor)
      @club_president = @club_period.try(:president)
      @club_vice_advisor = @club_period.try(:vice_advisor)

      @club_view_board_of_director = @club_period.club_board_of_director.present?
      @club_view_board_of_supervisor = @club_period.club_board_of_supervisory.present?
      @club_announcements = @club_period.announcements.where(is_view: true)
    end
    @club_members = @club.members
    @club_member_program_error = member_program_error?(@club, current_user)
    @member_blocked = current_user.present? && current_user.member_blocked?(@club)
  end

  def new
    @club = Club.new
    authorize @club
  end

  def edit
    @club.creation_date ||= Date.today
  end

  def create
    authorize Club
    @club = Club.new(club_params)
    respond_to do |format|
      if @club.save
        club_period = ClubPeriod.create(club_id: @club.id, academic_period_id: AcademicPeriod.active_period_id)
        club_setting = ClubSetting.create(club_id: @club.id, max_user: 150)
        if club_period && club_setting
          ClubBoardOfDirector.create(club_period_id: club_period.id)
          ClubBoardOfSupervisory.create(club_period_id: club_period.id)
          format.html { redirect_to @club, notice: 'Topluluk başarıyla oluşturuldu.' }
          format.json { render :show, status: :created, location: @club }
        else
          @club.destroy
          format.html { render :new }
          format.json { render json: @club.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :new }
        format.json { render json: @club.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @club
    respond_to do |format|
      if @club.update(club_params)
        format.html { redirect_to @club, notice: 'Topluluk bilgileri başarıyla güncellendi.' }
        format.json { render :show, status: :ok, location: @club }
      else
        format.html { render :edit }
        format.json { render json: @club.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @club
    @club.destroy
    respond_to do |format|
      format.html { redirect_to clubs_url, notice: 'Topluluk başarıyla silindi.' }
      format.json { head :no_content }
    end
  end

  private

  def set_club
    @club = Club.find(params[:id])
  end

  def club_params
    params.require(:club).permit(:name, :short_name, :description, :creation_date, :club_category_id, :logo)
  end
end
