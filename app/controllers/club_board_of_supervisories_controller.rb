class ClubBoardOfSupervisoriesController < ApplicationController
  before_action :set_club_board_of_supervisory, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]

  def index
    @club_board_of_supervisories = ClubBoardOfSupervisory.all
    authorize @club_board_of_supervisories
  end

  def show
    respond_to(:html, :xlsx)
  end

  def new
    @club_board_of_supervisory = ClubBoardOfSupervisory.new
    authorize @club_board_of_supervisory
  end

  def edit
  end

  def create
    @club_board_of_supervisory = ClubBoardOfSupervisory.new(club_board_of_supervisory_params)
    club_period = ClubPeriod.find(club_board_of_supervisory_params['club_period_id'])
    if ClubBoardOfSupervisory.where(club_period_id: club_period.id).any?
      flash.now[:error] = 'Daha önce bu topluluk için Denetim Kurulu oluşturulmuş. Lütfen onu düzenleyiniz.'
      render :new
    elsif duplicated_user_names = get_duplicated_user_names(club_period)
      flash.now[:error] = "#{duplicated_user_names} başka bir toplulukta yönetim kurulunda ya da denetim kurulunda."
      render :new
    else
      authorize @club_board_of_supervisory
      respond_to do |format|
        if @club_board_of_supervisory.save
          format.html { redirect_to @club_board_of_supervisory, notice: 'Denetim kurulu başarıyla oluşturuldu.' }
          format.json { render :show, status: :created, location: @club_board_of_supervisory }
        else
          format.html { render :new }
          format.json { render json: @club_board_of_supervisory.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def update
    authorize @club_board_of_supervisory
    club_period = ClubPeriod.find(club_board_of_supervisory_params['club_period_id'])
    if duplicated_user_names = get_duplicated_user_names(club_period, 'update')
      flash.now[:error] = "#{duplicated_user_names} başka bir toplulukta yönetim kurulunda ya da denetim kurulunda."
      render :new
    else
      respond_to do |format|
        if @club_board_of_supervisory.update(club_board_of_supervisory_params)
          format.html { redirect_to @club_board_of_supervisory, notice: 'Denetim kurulu başarıyla güncellendi.' }
          format.json { render :show, status: :ok, location: @club_board_of_supervisory }
        else
          format.html { render :edit }
          format.json { render json: @club_board_of_supervisory.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    authorize @club_board_of_supervisory
    @club_board_of_supervisory.destroy
    respond_to do |format|
      format.html { redirect_to club_board_of_supervisories_url, notice: 'Denetim kurulu başarıyla silindi.' }
      format.json { head :no_content }
    end
  end

  private

  def set_club_board_of_supervisory
    @club_board_of_supervisory = ClubBoardOfSupervisory.find(params[:id])
  end

  def club_board_of_supervisory_params
    params.require(:club_board_of_supervisory).permit(:club_period_id, :principal_member_one, :principal_member_two, :principal_member_three, :reserve_member_one, :reserve_member_two, :reserve_member_three)
  end

  # Başka toplulukta yönetim kurulunda ya da denetim kurulunda olanların tespiti
  def get_duplicated_user_names(club_period, action = '')
    all_club_board_of_directors = ClubBoardOfDirector.where(id: ClubBoardOfDirector.select { |cbod| cbod.id if cbod.club_period && cbod.club_period.academic_period.is_active })
    all_club_board_of_supervisories = ClubBoardOfSupervisory.where(id: ClubBoardOfSupervisory.select { |cbos| cbos.id if cbos.club_period && cbos.club_period.academic_period.is_active })
    all_club_board_of_supervisories_except = action == 'update' ? all_club_board_of_supervisories.where.not(club_period: club_period) : all_club_board_of_supervisories
    all_board_users = all_club_board_of_directors + all_club_board_of_supervisories_except
    duplicated_users = []
    club_board_of_supervisory_params.each do |attribute, user_id|
      if attribute != 'club_period_id'
        duplicated_users.push(User.find(user_id.to_i)) if all_board_users.map { |club_board| club_board.attributes.except('id', 'club_period_id').values.include?(user_id.to_i) }.any?
      end
    end
    # Başka toplulukta yönetim kurulunda ya da denetim kurulunda olan kullanıcılar
    duplicated_users = duplicated_users.uniq
    return unless duplicated_users.any?
    duplicated_user_names = ''
    duplicated_users.each do |user|
      duplicated_user_names = "#{duplicated_user_names}, #{user.name_surname}"
    end
    duplicated_user_names[2..duplicated_user_names.length]
  end
end
