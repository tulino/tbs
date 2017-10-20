module CheckDuplicatedUsers
  # Başka toplulukta yönetim kurulunda ya da denetim kurulunda olanların tespiti
  def get_duplicated_user_names(params)
    params = { action: '' }.merge(params)
    all_board_users = get_all_board_users(
      params[:club_period],
      params[:board_type],
      params[:action]
    )
    duplicated_users = get_duplicated_users(
      all_board_users,
      params[:club_board_params]
    )
    return unless duplicated_users.any?
    concat_duplicated_user_names(duplicated_users)
  end

  # Kullanıcı isimlerini birleştirir
  def concat_duplicated_user_names(duplicated_users)
    duplicated_user_names = ''
    duplicated_users.each do |user|
      duplicated_user_names = "#{duplicated_user_names}, #{user.name_surname}"
    end
    duplicated_user_names[2..duplicated_user_names.length]
  end

  # Kurullarda bulunan kullanıcılar
  def get_all_board_users(club_period, board_type, action)
    all_cbods = ClubBoardOfDirector.all_cbo_directors
    all_cboss = ClubBoardOfSupervisory.all_cbo_supervisories
    all_cbo_except =
      if board_type == ClubBoardOfDirector.board_type
        get_all_boards_by_action(club_period, all_cbods, action)
      elsif board_type == ClubBoardOfSupervisory.board_type
        get_all_boards_by_action(club_period, all_cboss, action)
      end
    case board_type
    when ClubBoardOfDirector.board_type then all_cboss + all_cbo_except
    when ClubBoardOfSupervisory.board_type then all_cbods + all_cbo_except
    end
  end

  # Action'a göre kurulların tamamını ya da kendi
  # kurulu dışındaki kurulları döndürür
  def get_all_boards_by_action(club_period, boards, action)
    if action == 'update'
      boards.where.not(club_period: club_period)
    else
      boards
    end
  end

  # Başka kurullarda bulunan kullanıcılar
  def get_duplicated_users(all_board_users, club_board_params)
    duplicated_users = []
    club_board_params.each do |attribute, user_id|
      if attribute != 'club_period_id'
        user_exists_in_club_board?(user_id.to_i, all_board_users) &&
          duplicated_users.push(User.find(user_id.to_i))
      end
    end
    duplicated_users.uniq
  end

  # Kullanıcı kurulda bulunuyor mu?
  def user_exists_in_club_board?(user_id, all_board_users)
    if User.exists?(user_id)
      all_board_users.map do |club_board|
        club_board
          .attributes
          .except('id', 'club_period_id')
          .values
          .include?(user_id)
      end.any?
    end
  end
end
