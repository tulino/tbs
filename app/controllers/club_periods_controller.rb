class ClubPeriodsController < ApplicationController
  before_action :set_club_period, only: [:show, :edit, :update, :destroy, :member_list, :edit_member_list]
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]

  def index
    @club_periods = ClubPeriod.where(academic_period_id: AcademicPeriod.active_period_id)
    authorize @club_periods
  end

  def member_list
    @member_list = @club_period.club_members.map(&:user)
    respond_to do |format|
      format.json { render json: @member_list }
    end
  end

  def edit_member_list
    @member_lists = @club_period.club_members
    respond_to(:html, :xlsx)
  end

  def change_member_status
    @club_member = Role.find(params[:id])
    @club_member.status = !@club_member.status
    @club_member.save
    redirect_to edit_member_list_club_period_path(@club_member.club_period.id)
  end

  def member_destroy
    @club_member = Role.find(params[:id])
    @club_member.destroy
    redirect_to edit_member_list_club_period_path(@club_member.club_period.id)
  end

  def club_type
    @club_category = ClubPeriod.find(params[:id]).club.club_category.name
    respond_to do |format|
      format.json { render :json => @club_category.to_json }
    end
  end

  def show
  end

  def new
    @club_period = ClubPeriod.new
    authorize @club_period
  end

  def edit
  end

  def create
    @club_period = ClubPeriod.new(club_period_params)
    authorize @club_period
    respond_to do |format|
      if @club_period.save
        format.html { redirect_to @club_period, notice: 'Topluluk dönemi başarıyla oluşturuldu.' }
        format.json { render :show, status: :created, location: @club_period }
      else
        format.html { render :new }
        format.json { render json: @club_period.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @club_period
    respond_to do |format|
      if @club_period.update(club_period_params)
        format.html { redirect_to @club_period, notice: 'Topluluk dönemi başarıyla düncellendi.' }
        format.json { render :show, status: :ok, location: @club_period }
      else
        format.html { render :edit }
        format.json { render json: @club_period.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @club_period.destroy
    authorize @club_period
    respond_to do |format|
      format.html { redirect_to club_periods_url, notice: 'Topluluk dönemi başarıyla silindi.' }
      format.json { head :no_content }
    end
  end

  private

  def set_club_period
    @club_period = ClubPeriod.find(params[:id])
  end

  def club_period_params
    params.require(:club_period).permit(:club_id, :name, :is_active, :academic_period_id)
  end
end
