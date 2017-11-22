class RolesController < ApplicationController
  before_action :set_role, only: %i[show edit update destroy status_edit]
  before_action :authenticate_user!

  def index
    @roles = Role.where.not(role_type_id: [RoleType.find_by(name: 'Başkan'), RoleType.find_by(name: 'Üye')])
    authorize @roles
  end

  def show
    authorize @role
  end

  def new
    @role = Role.new
  end

  def edit
    authorize @role
  end

  def create
    @role = Role.new(role_params)
    authorize @role
    duplicated_roles = check_duplicated_roles(@role)
    if duplicated_roles.present?
      flash.now[:error] = duplicated_roles
      redirect_to :back
    else
      create_role(@role)
    end
  end

  def update
    authorize @role
    respond_to do |format|
      if @role.update(role_params)
        format.html { redirect_to :back, notice: 'Kullanıcı rolünü başarıyla güncellediniz.' }
        format.json { render :show, status: :ok, location: @role }
      else
        format.html { render :edit }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @role
    @role.destroy
    notice_message =
      if current_user.admin?
        'Kullanıcıya atanmış rolü başarıyla iptal ettiniz.'
      else
        'Topluluk üyeliğinden başarıyla ayrıldınız.'
      end
    respond_to do |format|
      format.html { redirect_to :back, notice: notice_message }
      format.json { head :no_content }
    end
  end

  def memebership_status; end

  def status_edit; end

  private

  def check_duplicated_roles(role)
    role_type_member_id = RoleType.member_id
    role_type_president_id = RoleType.president_id
    role_type_dean_id = RoleType.dean_id
    all_active_period_ids = ClubPeriod.all_active_period_ids
    if role.role_type_id == role_type_member_id
      club_member_role?(role, role_type_member_id) &&
        "#{role.user.name_surname} geçerli toplulukta üyedir."
    elsif role.role_type_id == role_type_president_id
      if another_president_role?(role, role_type_president_id, all_active_period_ids)
        "#{role.user.name_surname} başka bir toplulukta başkan." \
        'Başkanlık için başka bir üye seçiniz.'
      elsif another_member_of_the_board?(role, all_active_period_ids)
        "#{role.user.name_surname} başka bir toplulukta yönetim kurulunda ya da denetim kurulunda." \
        'Başkanlık için başka bir üye seçiniz.'
      end
    elsif role.role_type_id == role_type_dean_id
      another_dean_role?(role, role_type_dean_id, all_active_period_ids) &&
        "#{role.user.name_surname} başka bir fakültede dekan." \
        'Dekanlık için başka bir fakülte seçiniz.'
    end
  end

  # Geçerli toplulukta üye mi?
  def club_member_role?(role, role_type_member_id)
    Role.where(
      role_type_id: role_type_member_id,
      club_id: role.club_id,
      user_id: role.user_id
    ).any?
  end

  # Başka bir toplulukta başkan mı?
  def another_president_role?(role, role_type_president_id, all_active_period_ids)
    Role.where(
      role_type_id: role_type_president_id,
      club_period_id: all_active_period_ids,
      user_id: role.user_id
    ).any?
  end

  # Başka bir toplulukta yönetim ya da denetim kurulunda mı?
  def another_member_of_the_board?(role, all_active_period_ids)
    all_board_users = ClubBoardOfSupervisory.where(club_period_id: all_active_period_ids) +
                      ClubBoardOfDirector.where(club_period_id: all_active_period_ids)
    all_board_users.map do |club_board|
      club_board.attributes.except('id', 'club_period_id').values.include?(role.user_id).any?
    end
  end

  # Başka bir fakültede dekan mı?
  def another_dean_role?(role, role_type_dean_id, all_active_period_ids)
    Role.where(
      role_type_id: role_type_dean_id,
      club_period_id: all_active_period_ids,
      faculty_id: role.faculty_id,
      user_id: role.user_id
    ).any?
  end

  def set_role
    @role = Role.find(params[:id])
  end

  def role_params
    params.require(:role).permit(
      :user_id, :faculty_id, :appointment_date, :club_period_id,
      :role_type_id, :status, :explanation, :club_id, :membership_start_date, :membership_end_date
    )
  end

  def create_role(role)
    respond_to do |format|
      if role.save
        path = 'back'.to_sym
        notice_message = 'Topluluğa başarıyla üyelik işleminizi başlattınız.'
        if current_user.admin? && !(request.referer.include? '/clubs/')
          path = roles_url
          notice_message = 'Kullanıcıya rol ataması başarıyla yapıldı.'
        end
        format.html { redirect_to path, notice: notice_message }
        format.json { render :show, status: :created, location: role }
      else
        format.html { render :new }
        format.json { render json: role.errors, status: :unprocessable_entity }
      end
    end
  end

end
