class ClubSettingsController < ApplicationController
  before_action :set_club_setting, only: %i[show edit update destroy]
  before_action :authenticate_user!, only: %i[new edit update destroy]

  def index
    @club_settings = ClubSetting.all
    authorize @club_settings
  end

  def show; end

  def new
    @club_setting = ClubSetting.new
    authorize @club_setting
  end

  def edit; end

  def create
    @club_setting = ClubSetting.new(club_setting_params)
    authorize @club_setting
    respond_to do |format|
      if @club_setting.save
        format.html { redirect_to @club_setting, notice: 'Topluluk ayarları başarıyla oluşturuldu.' }
        format.json { render :show, status: :created, location: @club_setting }
      else
        format.html { render :new }
        format.json { render json: @club_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @club_setting
    respond_to do |format|
      if @club_setting.update(club_setting_params)
        format.html { redirect_to @club_setting, notice: 'Topluluk ayarları başarıyla güncellendi.' }
        format.json { render :show, status: :ok, location: @club_setting }
      else
        format.html { render :edit }
        format.json { render json: @club_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @club_setting.destroy
    authorize @club_setting
    respond_to do |format|
      format.html { redirect_to club_settings_url, notice: 'Topluluk ayarları başarıyla silindi.' }
      format.json { head :no_content }
    end
  end

  private

  def set_club_setting
    @club_setting = ClubSetting.find(params[:id])
  end

  def club_setting_params
    params.require(:club_setting).permit(:club_id, :max_user, :is_active, :program_id)
  end
end
