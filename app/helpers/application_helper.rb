module ApplicationHelper
  BOOTSTRAP_FLASH_MSG = {
    success: 'alert-success',
    error: 'alert-danger',
    alert: 'alert-warning',
    notice: 'alert-info'
  }.freeze

  def bootstrap_class_for(flash_type)
    BOOTSTRAP_FLASH_MSG[flash_type.to_sym]
  end

  def flash_messages(_opts = {})
    flash.each do |msg_type, message|
      concat(
        content_tag(:div, message, class: "alert flash #{bootstrap_class_for(msg_type)} fade in") do
          concat content_tag(:button, 'x', class: 'close', data: { dismiss: 'alert' })
          concat message
        end
      )
    end
    nil
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  # Fotoğrafı varmı, yokmu? kontrolü
  def club_logo_or_not?(club, size = '50x50', opts = {})
    o = { class: '' }.merge(opts)
    if club.logo.present?
      image_tag(club.logo, size: size, class: o[:class])
    else
      placeholder_club_logo(size)
    end
  end

  # Fotoğrafı yoksa gösterilecek imaj
  def placeholder_club_logo(size)
    image_tag('club_placeholder.png', alt: 'club-placeholder', size: size)
  end

  # Fotoğrafı varmı, yokmu? kontrolü
  def avatar_or_not?(user, version, size="180x240", opts={})
    o = {class: "", style: ""}.merge(opts)
    if user.present? && user.image.present?
      image_tag(user.image.url(version), class: o[:class], style: o[:style])
    else
      placeholder_image(size)
    end
  end

  def profile_or_not?(record)
    if record.show_profile?(current_user)
      link_to record.full_name, profile_path(record.profile)
    else
      record.full_name
    end
  end

  # Fotoğrafı yoksa gösterilecek imaj
  def placeholder_image(size)
    image_tag('avatar_placeholder.png', alt: 'avatar-placeholder', size: size)
  end

  def blank_for_attributes?(record)
    !record.attributes.except('id', 'created_at', 'updated_at').values.all?
  end

  def blank_for_attribute(record, name_attribute)
    record.instance_eval(name_attribute) unless record.blank?
  end

  def ubs_no_valid?(ogrenci_no)
    (ogrenci_no.length == 8 && !(ogrenci_no.start_with? 'o')) || (ogrenci_no.length == 9 && (ogrenci_no.start_with? 'o'))
  end

  def admin_users
    User.where(id: RoleType.find_by(name: 'Admin').roles.pluck(:user_id)).map { |x| x.profile.email }
  end
end
