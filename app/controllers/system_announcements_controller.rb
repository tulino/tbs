class SystemAnnouncementsController < ApplicationController
  before_action :set_system_announcement, only: %i[show edit update destroy]
  before_action :authenticate_user!, only: %i[new edit update destroy]

  def index
    @system_announcements = SystemAnnouncement.order('created_at DESC').page params[:page]
    @system_announcements = @system_announcements.where(is_view: true) unless user_signed_in? && current_user.admin?
    authorize @system_announcements
  end

  def show
    authorize @system_announcement
  end

  def new
    @system_announcement = SystemAnnouncement.new
    authorize @system_announcement
  end

  def edit
    body
  end

  def create
    @system_announcement = SystemAnnouncement.new(system_announcement_params)
    authorize @system_announcement
    respond_to do |format|
      if @system_announcement.save
        format.html { redirect_to @system_announcement, notice: 'Sistem duyurusu başarıyla oluşturuldu.' }
        format.json { render :show, status: :created, location: @system_announcement }
      else
        format.html { render :new }
        format.json { render json: @system_announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @system_announcement
    respond_to do |format|
      if @system_announcement.update(system_announcement_params)
        format.html { redirect_to @system_announcement, notice: 'Sistem duyurusu başarıyla güncellendi.' }
        format.json { render :show, status: :ok, location: @system_announcement }
      else
        format.html { render :edit }
        format.json { render json: @system_announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @system_announcement.destroy
    authorize @system_announcement
    respond_to do |format|
      format.html { redirect_to system_announcements_path, notice: 'Sistem duyurusu başarıyla silindi.' }
      format.json { head :no_content }
    end
  end

  private

  def set_system_announcement
    @system_announcement = SystemAnnouncement.find(params[:id])
  end

  def system_announcement_params
    params.require(:system_announcement).permit(:title, :content, :is_view, :status)
  end
end
