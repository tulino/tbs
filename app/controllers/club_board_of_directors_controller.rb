class ClubBoardOfDirectorsController < ApplicationController
  include CheckDuplicatedUsers
  before_action :set_club_board_of_director, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]

  def index
    @club_board_of_directors = ClubBoardOfDirector.all
    authorize @club_board_of_directors
  end

  def show
    respond_to(:html, :xlsx)
  end

  def new
    @club_board_of_director = ClubBoardOfDirector.new
    authorize @club_board_of_director
  end

  def edit
  end

  def create
    @club_board_of_director = ClubBoardOfDirector.new(club_board_of_director_params)
    club_period = ClubPeriod.find(club_board_of_director_params['club_period_id'])
    params = {
      club_period: club_period,
      board_type: ClubBoardOfDirector.board_type,
      club_board_params: club_board_of_director_params
    }
    if ClubBoardOfDirector.where(club_period_id: club_period.id).any?
      flash.now[:error] = 'Daha önce bu topluluk için Yönetim Kurulu oluşturulmuş. Lütfen onu düzenleyiniz.'
      render :new
    elsif duplicated_user_names = get_duplicated_user_names(params)
      flash.now[:error] = "#{duplicated_user_names} başka bir toplulukta yönetim kurulunda ya da denetim kurulunda."
      render :new
    else
      authorize @club_board_of_director
      respond_to do |format|
        if @club_board_of_director.save
          president_update_or_create(@club_board_of_director) unless @club_board_of_director.president.blank?
          format.html { redirect_to @club_board_of_director, notice: 'Yönetim kurulu başarıyla oluşturuldu.' }
          format.json { render :show, status: :created, location: @club_board_of_director }
        else
          format.html { render :new }
          format.json { render json: @club_board_of_director.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def update
    authorize @club_board_of_director
    club_period = ClubPeriod.find(club_board_of_director_params['club_period_id'])
    params = {
      club_period: club_period,
      board_type: ClubBoardOfDirector.board_type,
      club_board_params: club_board_of_director_params,
      action: 'update'
    }
    if duplicated_user_names = get_duplicated_user_names(params)
      flash.now[:error] = "#{duplicated_user_names} başka bir toplulukta yönetim kurulunda ya da denetim kurulunda."
      render :new
    else
      respond_to do |format|
        if @club_board_of_director.update(club_board_of_director_params)
          president_update_or_create(@club_board_of_director) unless @club_board_of_director.president.blank?
          format.html { redirect_to @club_board_of_director, notice: 'Yönetim kurulu başarıyla güncellendi.' }
          format.json { render :show, status: :ok, location: @club_board_of_director }
        else
          format.html { render :edit }
          format.json { render json: @club_board_of_director.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    @club_board_of_director.destroy
    authorize @club_board_of_director
    respond_to do |format|
      format.html { redirect_to club_board_of_directors_url, notice: 'Yönetim kurulu başarıyla silindi.' }
      format.json { head :no_content }
    end
  end

  def president_update_or_create(club_board_of_director)
    role = Role.president?(club_board_of_director.club_period_id)
    role.present? ? role.update(user_id: club_board_of_director.president.id) : Role.create(club_period_id: club_board_of_director.club_period_id, role_type_id: RoleType.find_by(name: 'Baskan').id, user_id: club_board_of_director.president.id, status: true)
  end

  private

  def set_club_board_of_director
    @club_board_of_director = ClubBoardOfDirector.find(params[:id])
  end

  def club_board_of_director_params
    params.require(:club_board_of_director).permit(:club_period_id, :president_id, :vice_president_id, :accountant_id, :secretary_id, :member_one, :member_two, :member_three)
  end

end
