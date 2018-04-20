class UsersController < ApplicationController
  def index
    authorize User.new
    respond_to do |format|
      format.html
      format.json do
        render json: UsersDatatable.new(view_context)
      end
    end
  end

  def find_ogrenci
    if params['ubs_no'].present? && params['club_id'].present?
      params['ubs_no'] = 'o' + params['ubs_no'] if ubs_no_valid?(params['ubs_no']) && !(params['ubs_no'].start_with? 'o')
      if params['ubs_no'].length == 9 && (params['ubs_no'].start_with? 'o')
        @user = User.find_by(ubs_no: params['ubs_no'])
        @user = Ubs.control_student(params['ubs_no']) unless @user.present?
        if @user.present? && @user.is_ubs_active && Role.where(club_period_id: params['club_id']).none? { |x| x.user_id == @user.id }
          @role = Role.new
          @role.role_type_id = RoleType.find_by(name: 'Üye').id
          @role.user_id = User.find_by(ubs_no: params['ubs_no']).id
          @role.club_period_id = params['club_id'].to_i
          @role.save
        end
      end
    end
    @uyari =
      if !params['ubs_no'].present? || !ubs_no_valid?(params['ubs_no'])
        'Girdiğiniz öğrenci numarası hatalı'
      elsif params['club_id'].blank?
        'Lütfen önce topluluk seçiniz'
      elsif !User.find_by(ubs_no: params['ubs_no']).is_ubs_active
        'Öğrenci aktif olmadığı için eklenemedi!'
      end
    if @uyari.present?
      flash[:error] = @uyari
    else
      flash[:success] = 'Öğrenciyi listeye eklediniz. Lütfen listeden seçiniz'
    end
    flash[:error] = @uyari
    respond_to do |format|
      format.js { render inline: 'location.reload();' }
    end
  end

  def find_personel
    if params['idnumber'].present? && params['club_id'].present?
      @user = User.find_by(idnumber: params['idnumber'])
      @user = Ubs.control_academic(params['idnumber']) unless @user.present?
    end
    @uyari =
      if params['idnumber'].blank?
        'Girdiğiniz Tc kimlik numarası hatalı'
      elsif params['club_id'].blank?
        'Lütfen önce topluluk seçiniz'
      elsif User.find_by(idnumber: params['idnumber']).blank?
        'Akademik danışman aktif olmadığı için sisteme eklenmedi!'
      end
    if @uyari.present?
      flash[:error] = @uyari
    else
      flash[:success] = 'Akademik danışmanı listeye eklediniz. Lütfen listeden seçiniz'
    end
    respond_to do |format|
      format.js { render inline: 'location.reload();' }
    end
  end
end
