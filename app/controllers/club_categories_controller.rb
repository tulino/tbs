class ClubCategoriesController < ApplicationController
  before_action :set_club_category, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]

  def index
    @club_categories = ClubCategory.all
    authorize @club_categories
  end

  def show; end

  def new
    @club_category = ClubCategory.new
    authorize @club_category
  end

  def edit; end

  def create
    @club_category = ClubCategory.new(club_category_params)
    authorize @club_category
    respond_to do |format|
      if @club_category.save
        format.html { redirect_to @club_category, notice: 'Topluluk kategorisi başarıyla oluşturuldu.' }
        format.json { render :show, status: :created, location: @club_category }
      else
        format.html { render :new }
        format.json { render json: @club_category.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @club_category
    respond_to do |format|
      if @club_category.update(club_category_params)
        format.html { redirect_to @club_category, notice: 'Topluluk kategorisi başarıyla güncellendi.' }
        format.json { render :show, status: :ok, location: @club_category }
      else
        format.html { render :edit }
        format.json { render json: @club_category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @club_category
    @club_category.destroy
    respond_to do |format|
      format.html { redirect_to club_categories_url, notice: 'Topluluk kategorisi başarıyla silindi.' }
      format.json { head :no_content }
    end
  end

  private

  def set_club_category
    @club_category = ClubCategory.find(params[:id])
  end

  def club_category_params
    params.require(:club_category).permit(:name)
  end
end
