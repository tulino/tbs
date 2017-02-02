class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  require 'rest-client'
  has_many :roles, dependent: :destroy
  has_many :advisors
  has_many :assistant_consultants
  has_one  :profile, dependent: :destroy
  # has_many :club_board_of_directors
  # has_many :club_board_of_supervisory

  mount_uploader :image, ImageUploader

  def admin?
    roles.any? { |r| r.role_type_id == RoleType.find_by_name('Admin').id }
  end

  def advisor?(club_period_id = active_club_periods)
    @role_type_id = RoleType.find_by_name('Akademik Danışman').id
    if vice_advisor?(club_period_id)
      advisor = Role.where(club_period_id: club_period_id, role_type_id: @role_type_id, status: true).first.user
      if advisor.is_passive.present? && advisor.is_passive
        roles.where(club_period_id: club_period_id, role_type_id: @role_type_id, status: true).present? ? true : false
      else
        roles.where(club_period_id: club_period_id, role_type_id: @role_type_id, status: true).present? ? true : false
      end
    else
      @role_type_id = RoleType.find_by_name('Akademik Danışman').id
      roles.where(club_period_id: club_period_id, role_type_id: @role_type_id, status: true).present? ? true : false
    end
  end

  def vice_advisor?(club_period_id = active_club_periods)
    @role_type_id = RoleType.find_by_name('Akademik Danışman Yardımcısı').id
    roles.where(club_period_id: club_period_id, role_type_id: @role_type_id, status: true).present? ? true : false
  end

  def president?(club_period_id = active_club_periods)
    @role_type_id = RoleType.find_by_name('Başkan').id
    roles.where(club_period_id: club_period_id, role_type_id: @role_type_id, status: true).present? ? true : false
  end

  def member?(club_period_id = active_club_periods)
    @role_type_id = RoleType.find_by_name('Üye').id
    roles.where(club_period_id: club_period_id, role_type_id: @role_type_id, status: true).present? ? true : false
  end

  def dean?
    @role_type_id = RoleType.find_by_name('Dekan').id
    roles.where(role_type_id: @role_type_id, status: true).present? ? true : false
  end

  def owner_of_role?(role)
    id == role.user.id ? true : false
  end

  def active_club_periods
    return unless roles.present?
    current_user_roles = roles.includes(:club_period)
    current_user_roles.map { |role| role.club_period if role.club_period.present? && role.club_period.academic_period.is_active }.uniq
  end

  def president_or_advisor_club_period
    return nil unless president? || advisor?
    roles.select { |role| (role.club_period.academic_period.is_active unless role.club_period.blank?) && (role.role_type.name == 'Başkan' || role.role_type.name == 'Akademik Danışman') }.first.club_period
  end

  #### Yardımcı Fonksiyonlar
  def full_name
    if is_academic?
      degree.present? ? degree + ' ' + first_name + ' ' + last_name : first_name + ' ' + last_name
    else
      first_name + ' ' + last_name
    end
  end

  def crime?
    profile.crime ? 'Disiplin Cezası Var, Topluluklara Üye Olamaz' : 'Disiplin Cezası Yok, Topluluklara Üye Olabilir'
  end

  def ubs_active?
    is_ubs_active ? 'Aktif' : 'Aktif Değil'
  end

  def name_surname
    first_name + ' ' + last_name
  end

  def show_profile?(user)
    user.admin? || user.advisor? || user.president? || user.vice_advisor? unless user.blank?
  end
end
