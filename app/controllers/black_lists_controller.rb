class BlackListsController < ApplicationController
  before_action :set_black_list, only: [:edit, :update, :destroy, :change_approve_status]

  # GET /black_lists
  # GET /black_lists.json
  def index
    @black_lists = BlackList.all
    authorize @black_lists
  end

  # GET /black_lists/new
  def new
    @black_list = BlackList.new
    authorize @black_list
  end

  # GET /black_lists/1/edit
  def edit
    authorize @black_list
  end

  def change_approve_status
    authorize @black_list, :change_approve_status?
    @black_list.approved = !@black_list.approved
    @black_list.save
    if @black_list
      club = @black_list.club
      club_period_id = club.active_club_period.id
      user_id = @black_list.user_id
      Role.find_by(
        club_period_id: club_period_id,
        user_id: user_id,
        role_type_id: RoleType.member_id
      ).destroy
    end
    redirect_to black_lists_path
  end

  # POST /black_lists
  # POST /black_lists.json
  def create
    @black_list = BlackList.new(black_list_params)
    authorize @black_list
    respond_to do |format|
      if @black_list.save
        location = 
          if current_user.admin?
            @black_list
          elsif current_user.president?
            club_users_path
          end
        format.html { redirect_to location, notice: 'Üyelik iptal talebi başarıyla oluşturuldu.' }
        format.json { render :show, status: :created, location: location }
      else
        format.html { render :new }
        format.json { render json: @black_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /black_lists/1
  # PATCH/PUT /black_lists/1.json
  def update
    authorize @black_list
    respond_to do |format|
      if @black_list.update(black_list_params)
        format.html { redirect_to @black_list, notice: 'Üyelik iptal talebi başarıyla güncellendi.' }
        format.json { render :show, status: :ok, location: @black_list }
      else
        format.html { render :edit }
        format.json { render json: @black_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /black_lists/1
  # DELETE /black_lists/1.json
  def destroy
    authorize @black_list
    @black_list.destroy
    respond_to do |format|
      format.html { redirect_to black_lists_url, notice: 'Üyelik iptal talebi başarıyla silindi.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_black_list
    @black_list = BlackList.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def black_list_params
    params.require(:black_list).permit(:club_id, :user_id, :approve, :explanation)
  end
end
