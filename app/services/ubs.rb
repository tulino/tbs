module Ubs
  def self.login(user)
    result = student_login(username: user.ubs_no, password: Digest::MD5.hexdigest(user.password))
    return unless result
    control_user(result)
  end

  def self.control_student(ubs_no)
    result = student_add(username: ubs_no)
    return  unless result
    control_user(result)
  end

  def self.control_user(params)
    user = User.find_by_ubs_no('o' + params['student_id'])
    if user.present?
      user.profile.update(crime: params['crime'].present?)
      user.update(is_ubs_active: params['state_id'].present? && params['state_id'] == '905002')
      return user
    end
    names = params['full_name'].split(' ')
    if names.count == 3
      first_name = names[0] + ' ' + names[1]
      last_name = names[2]
    else
      first_name = names[0]
      last_name = names[1]
    end
    user = User.create(
      first_name: first_name,
      last_name: last_name,
      password: params['student_id'],
      email: params['student_id'] + '@stu.omu.edu.tr',
      user_name: 'o' + params['student_id'],
      is_administrative: false,
      ubs_no: 'o' + params['student_id'],
      is_ubs_active: params['state_id'].present? && params['state_id'] == '905002'
    )
    user.profile = Profile.create(
      full_name: params['full_name'],
      birthday: params['birthday'].to_datetime,
      faculty: params['faculty'],
      program: params['program'],
      program_id: params['program_id'],
      crime: params['crime'].present?
    )
    return user
  end

  def self.active_academic_control(tc_no)
    result = staff_info(identifyNumber: tc_no)
    academic_user = User.find_by_idnumber(result['idnumber'])
    return   unless academic_user.present?
    academic_user.update(is_ubs_active: result['state'].present? && result['state'] == '1')
    result['state'].present? && result['state'] == '1'
  end

  def self.control_academic(tc_no)
    result = staff_info(identifyNumber: tc_no)
    return  unless result && result['state'].present? && result['state'] == '1'
    full_name = "#{result['first_name']} #{result['last_name']}"
    email_name = full_name.parameterize.underscore
    user = User.create(
      first_name: result['first_name'],
      last_name: result['last_name'],
      password: tc_no,
      email: email_name.downcase + '@omu.edu.tr',
      user_name: result['short_title'],
      is_administrative: false,
      idnumber: tc_no,
      is_academic: true,
      degree: result['short_title'],
      is_ubs_active: result['state'].present? && result['state'] == '1'
    )
    user.profile = Profile.new(
      full_name: result['first_name'] + ' ' + result['last_name'],
      email: result['email']
    )
  end

  def self.student_login(params)
    api(params.merge(query_type: 'student_login'))
  end

  def self.student_add(params)
    api(params.merge(query_type: 'student_add'))
  end

  def self.staff_info(params)
    api(params.merge(query_type: 'staff_info'))
  end

  def self.api(params)
    params = params_for(params)
    return unless params
    response_data = RestClient.post(params[:url], params)
    return if response_data.code != 200
    return if response_data.to_s == '1'
    JSON.parse(response_data)
  end

  def self.params_for(params)
    p = APP_CONFIG[:ubs_api].merge params
    case p[:query_type]
    when 'student_login'
      message = p[:client] + p[:store_key] + p[:random] + p[:username] + p[:password] + p[:query_type]
    when 'student_add'
      message = p[:client] + p[:store_key] + p[:random] + p[:username] + p[:query_type]
    when 'staff_info'
      message = p[:client] + p[:store_key] + p[:random] + p[:identifyNumber] + p[:query_type]
    else
      return nil
    end
    p[:hash] = Digest::SHA1.hexdigest(message)
    p
  end
end
