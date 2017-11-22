class ClubSlidesController < ApplicationController
  before_action :set_club_slide, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @club_slides = ClubSlide.where(club_id: current_user.roles_users.find_by(status: :true, role_id: Role.find_by(role_type_id: RoleType.find_by(name: :advisor))).role.club_id)
    authorize @club_slides
  end

  def show; end

  def new
    @club_slide = ClubSlide.new
    authorize @club_slide
  end

  def edit; end

  def create
    @club_slide = ClubSlide.new(club_slide_params)
    authorize @club_slide
    respond_to do |format|
      if @club_slide.save
        format.html { redirect_to @club_slide, notice: "Topluluk slide'ı başarıyla oluşturuldu." }
        format.json { render :show, status: :created, location: @club_slide }
      else
        format.html { render :new }
        format.json { render json: @club_slide.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @club_slide
    respond_to do |format|
      if @club_slide.update(club_slide_params)
        format.html { redirect_to @club_slide, notice: "Topluluk slide'ı başarıyla güncellendi." }
        format.json { render :show, status: :ok, location: @club_slide }
      else
        format.html { render :edit }
        format.json { render json: @club_slide.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @club_slide
    @club_slide.destroy
    respond_to do |format|
      format.html { redirect_to club_slides_url, notice: "Topluluk slide'ı başarıyla silindi." }
      format.json { head :no_content }
    end
  end

  private

  def set_club_slide
    @club_slide = ClubSlide.find(params[:id])
  end

  def club_slide_params
    params.require(:club_slide).permit(:file, :title, :club_id)
  end
end
