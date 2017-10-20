class AnnouncementsController < ApplicationController
  before_action :set_announcment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]

  def index
    @announcements =
      if current_user.admin?
        Announcement.all
      elsif current_user.advisor?
        club_period = ClubPeriod.find_by(id: current_user.active_club_periods.select { |clubperiod| var.id if current_user.advisor?(clubperiod) })
        club_period.nil? ? [] : Announcement.where(club_period_id: club_period.id)
      elsif current_user.president?
        club_period = ClubPeriod.find_by(id: current_user.active_club_periods.select { |clubperiod| clubperiod.id if current_user.president?(clubperiod) })
        club_period.nil? ? [] : Announcement.where(club_period_id: club_period.id)
      else
        Announcement.all
      end
    authorize @announcements
  end

  def show
    authorize @announcement
  end

  def new
    @announcement = Announcement.new
    authorize @announcement
  end

  def edit
  end

  def create
    @announcement = Announcement.new(announcment_params)
    authorize @announcement
    respond_to do |format|
      if @announcement.save
        format.html { redirect_to @announcement, notice: 'Duyuru başarıyla oluşturuldu.' }
        format.json { render :show, status: :created, location: @announcement }
      else
        format.html { render :new }
        format.json { render json: @announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @announcement
    respond_to do |format|
      if @announcement.update(announcment_params)
        format.html { redirect_to @announcement, notice: 'Duyuru başarıyla güncellendi.' }
        format.json { render :show, status: :ok, location: @announcement }
      else
        format.html { render :edit }
        format.json { render json: @announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @announcement
    @announcement.destroy
    respond_to do |format|
      format.html { redirect_to announcments_url, notice: 'Duyuru başarıyla silindi.' }
      format.json { head :no_content }
    end
  end

  private

  def set_announcment
    @announcement = Announcement.find(params[:id])
  end

  def announcment_params
    params.require(:announcement).permit(:club_period_id, :title, :content, :is_view, :is_advisor_confirmation)
  end
end
