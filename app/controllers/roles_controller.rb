class RolesController < ApplicationController
  before_action :set_role, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @roles = Role.where.not(role_type_id: [RoleType.find_by(name: 'Başkan'), RoleType.find_by(name: 'Üye')])
    authorize @roles
  end

  def unsubscribe_request
    @roles = Role.where(status: false)
    authorize @roles
  end

  def club_users
    club_period = current_user.president_or_advisor_club_period
    @roles = club_period.club_members
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
    role_type_president = RoleType.find_by(name: 'Başkan')
    role_type_dean = RoleType.find_by(name: 'Dekan')
    role_type_member = RoleType.find_by(name: 'Üye')
    if @role.role_type == role_type_president
      has_another_president_role = Role.where(role_type_id: role_type_president.id).map { |role| role.user.id }.include?(@role.user.id)
      # Başka bir toplulukta başkan mı? kontrolü
      if has_another_president_role
        flash.now[:error] = "#{@role.user.name_surname} başka bir toplulukta başkan. Başkanlık için başka bir üye seçiniz."
        render :new
      else
        all_board_users = ClubBoardOfSupervisory.all + ClubBoardOfDirector.all
        is_member_of_the_board = all_board_users.map { |club_board| club_board.attributes.except('id', 'club_period_id').values.include?(@role.user.id) }.any?
        # Başka bir toplulukta yönetim ya da denetim kurulunda mı? kontrolü
        if is_member_of_the_board
          flash.now[:error] = "#{@role.user.name_surname} başka bir toplulukta yönetim kurulunda ya da denetim kurulunda. Başkanlık için başka bir üye seçiniz."
          render :new
        else
          create_role(@role)
        end
      end
    elsif @role.role_type == role_type_dean

      has_another_dean_role = Role.where(role_type_id: role_type_dean.id, faculty_id: @role.faculty_id).map { |role| role.user.id }.include?(@role.user.id)
      if has_another_dean_role
        flash.now[:error] = "#{@role.user.name_surname} başka bir fakültede dekan. Dekanlık için başka bir Fakülte seçiniz."
        render :new
      else
        create_role(@role)
      end

    elsif @role.role_type == role_type_member
      has_another_member_role = Role.where(role_type_id: role_type_member.id, club_period_id: @role.club_period_id, user_id: @role.user_id)
      if has_another_member_role
        flash.now[:error] = "#{@role.user.name_surname} daha önce bu topluluğa üye olmuşsunuz. Lütfen sayfayı yenileyiniz."
        render :new
      else
        create_role(@role)
      end
    else
      create_role(@role)
    end
  end

  def update
    authorize @role
    # if @role.status && @role.explanation
    #   @role.explanation = nil
    # end
    respond_to do |format|
      if @role.update(role_params)
        format.html { redirect_to @role, notice: 'Kullanıcı rolünü başarıyla güncellediniz.' }
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
    path = 'back'.to_sym
    notice_message = 'Topluluk üyeliğinden başarıyla ayrıldınız.'
    if current_user.admin? && !(request.referer.include? '/clubs/')
      path = roles_url
      notice_message = 'Kullanıcıya atanmış rolü başarıyla iptal ettiniz.'
    end
    respond_to do |format|
      format.html { redirect_to path, notice: notice_message }
      format.json { head :no_content }
    end
  end

  private

  def set_role
    @role = Role.find(params[:id])
  end

  def role_params
    params.require(:role).permit(:user_id, :faculty_id, :appointment_date, :club_period_id, :role_type_id, :status, :explanation)
  end

  def create_role(role)
    respond_to do |format|
      if role.save
        path = 'back'.to_sym
        notice_message = 'Topluluğa başarıyla üye oldunuz.'
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
