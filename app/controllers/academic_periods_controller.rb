class AcademicPeriodsController < ApplicationController
  before_action :set_academic_period, only: %i[show edit update destroy]
  before_action :authenticate_user!

  def index
    @academic_periods = AcademicPeriod.all
    authorize @academic_periods
  end

  def show
    authorize @academic_period
  end

  def new
    @academic_period = AcademicPeriod.new
    authorize @academic_period
  end

  def edit
    authorize @academic_period
  end

  def create
    @academic_period = AcademicPeriod.new(academic_period_params)
    authorize @academic_period

    respond_to do |format|
      if @academic_period.save
        format.html { redirect_to @academic_period, notice: 'Akademik dönem başarıyla oluşturuldu.' }
        format.json { render :show, status: :created, location: @academic_period }
      else
        format.html { render :new }
        format.json { render json: @academic_period.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @academic_period
    respond_to do |format|
      if @academic_period.update(academic_period_params)
        if @academic_period.is_active
          academic_periods_except = AcademicPeriod.academic_periods_except(@academic_period)
          academic_periods_except.update_all(is_active: false)
          Club.all.each do |club|
            ClubPeriod.create(club_id: club.id, academic_period_id: @academic_period.id) unless club.club_periods.find_by(academic_period_id: @academic_period.id).present?
          end
        end
        format.html { redirect_to @academic_period, notice: 'Akademik dönem başarıyla güncellendi.' }
        format.json { render :show, status: :ok, location: @academic_period }
      else
        format.html { render :edit }
        format.json { render json: @academic_period.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @academic_period
    @academic_period.destroy
    respond_to do |format|
      format.html { redirect_to academic_periods_url, notice: 'Akademik dönem başarıyla silindi.' }
      format.json { head :no_content }
    end
  end

  private

  def set_academic_period
    @academic_period = AcademicPeriod.find(params[:id])
  end

  def academic_period_params
    params.require(:academic_period).permit(:name, :is_active)
  end
end
