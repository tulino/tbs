# club_category , club , club_settings , club_period , user ,
# event_category , role , roles_user , system_announcement , announcement
# modellerine seed verisi eklenmiştir.

@academic_period = AcademicPeriod.create(name: '2015-2016', is_active: true)

# club_category
@club_category = ClubCategory.create([{ name: 'Sosyal Topluluk' }, { name: 'Mesleki Topluluk' }])

# eventCategory
EventCategory.create([{ name: 'Eğitim' }, { name: 'Festival' }, { name: 'Gezi' }, { name: 'Film-Gösteri-Şölen' }])
EventCategory.create([{ name: 'Konferans' }, { name: 'Kongre' }, { name: 'Konser-Dinleti' }, { name: 'Çalıştay' }])
EventCategory.create([{ name: 'Panel' }, { name: 'Seminer' }, { name: 'Sempozyum' }, { name: 'Sergi' }])
EventCategory.create([{ name: 'Söyleşi' }, { name: 'Kurs' }, { name: 'Yarışma' }, { name: 'Spor' }])
EventCategory.create([{ name: 'Yardım Kampanyası' }, { name: 'Topluluk Toplantısı' }, { name: 'Anma' }, { name: 'Ödül Töreni' }])

# club
@club = Club.create(name: 'Siber Güvenlik Topluluğu', short_name: 'siber-guvenlik-toplulugu', description: 'Topluluk üniversite öğrencilerinde siber güvenlik farkındalığı sağlamak temel amacıdır.', is_active: true, club_category_id: ClubCategory.find_by_name('Sosyal Topluluk').id, creation_date: DateTime.now)

# club-period
@club_period = ClubPeriod.create(club_id: @club.id, academic_period_id: @academic_period.id)

# roller
@role_type_advisor = RoleType.create(name: 'Akademik Danışman')
@role_type_advisor_y = RoleType.create(name: 'Akademik Danışman Yardımcısı')
@role_type_president = RoleType.create(name: 'Başkan')
@role_type_member = RoleType.create(name: 'Üye')
@role_type_admin = RoleType.create(name: 'Admin')

# admin kullanıcı
@user = User.create(first_name: 'Admin', last_name: 'Kullanıcı', user_name: 'admin', email: 'admin@tbs.com', password: 'admin123', is_administrative: true, idnumber: '00000000000')
@profile_admin = Profile.create(full_name: @user.first_name + ' ' + @user.last_name, user_id: @user.id)
@rol_admin = Role.create(user_id: @user.id, role_type_id: @role_type_admin.id)

# announcement
Announcement.create(club_period_id: @club_period.id, title: 'Siber g. Duyuru 1', content: 'test', is_view: true, is_advisor_confirmation: true)
Announcement.create(club_period_id: @club_period.id, title: 'Siber g. Duyuru 2', content: 'testtttt', is_view: true, is_advisor_confirmation: false)
Announcement.create(club_period_id: @club_period.id, title: 'Siber g. Duyuru 3', content: 'testaaaaaa', is_view: false, is_advisor_confirmation: true)

# club-setting
ClubSetting.create(club_id: @club.id, max_user: 150)

# users
@user_advisor = User.create(first_name: 'Akademik Danışman', idnumber: '12345678912', last_name: 'Siber G.', user_name: 'advisor-siber', email: 'advisor-siber@tbs.com', password: 'advisor123', is_academic: true, degree: 'Prof. Dr.')
@user_president = User.create(first_name: 'Başkan', last_name: 'Siber G.', ubs_no: 'o11111111', user_name: 'president-siber', email: 'president-siber@tbs.com', password: 'president123', program_code: '2728')
@user_member = User.create(first_name: 'Üye', last_name: 'Siber G.', ubs_no: 'o22222222', user_name: 'member-siber', email: 'member-siber@tbs.com', password: 'member123', program_code: '2728')

# club roles
Role.create(user_id: @user_advisor.id, club_period_id: @club_period.id, role_type_id: @role_type_advisor.id)
Role.create(user_id: @user_president.id, club_period_id: @club_period.id, role_type_id: @role_type_president.id)
Role.create(user_id: @user_member.id, club_period_id: @club_period.id, role_type_id: @role_type_member.id)

Profile.create(full_name: @user_advisor.first_name + ' ' + @user_advisor.last_name, user_id: @user_advisor.id)
Profile.create(full_name: @user_president.first_name + ' ' + @user_president.last_name, user_id: @user_president.id)
Profile.create(full_name: @user_member.first_name + ' ' + @user_member.last_name, user_id: @user_member.id)

# club
@club = Club.create(name: 'Bisiklet Topluluğu', short_name: 'bisiklet-toplulugu', description: 'Bisikletin önemini ve yaygınlaşmasını amaçlamış bir topluluktur.', is_active: true, club_category_id: ClubCategory.find_by_name('Sosyal Topluluk').id, creation_date: DateTime.now)

# club-period
@club_period = ClubPeriod.create(club_id: @club.id, academic_period_id: @academic_period.id)

# announcement
Announcement.create(club_period_id: @club_period.id, title: 'Bisiklet. Duyuru 1', content: 'test', is_view: true, is_advisor_confirmation: true)
Announcement.create(club_period_id: @club_period.id, title: 'Bisiklet. Duyuru 2', content: 'testtttt', is_view: true, is_advisor_confirmation: false)
Announcement.create(club_period_id: @club_period.id, title: 'Bisiklet. Duyuru 3', content: 'testaaaaaa', is_view: false, is_advisor_confirmation: true)

# club-setting
@club_setting = ClubSetting.create(club_id: @club.id, max_user: 150)

# users
@user_advisor = User.create(first_name: 'Akademik Danışman', last_name: 'Bisiklet.', idnumber: '98765432198', user_name: 'advisor-bisiklet', email: 'advisor-bisiklet@tbs.com', password: 'advisor123', is_academic: true, degree: 'Prof. Dr.')
@user_president = User.create(first_name: 'Başkan', last_name: 'Bisiklet.', ubs_no: 'o33333333', user_name: 'president-bisiklet', email: 'president-bisiklet@tbs.com', password: 'president123', program_code: '2728')
@user_member = User.create(first_name: 'Üye', last_name: 'Bisiklet.', ubs_no: 'o44444444', user_name: 'member-bisiklet', email: 'member-bisiklet@tbs.com', password: 'member123', program_code: '2728')

# club roles
Role.create(user_id: @user_advisor.id, club_period_id: @club_period.id, role_type_id: @role_type_advisor.id)
Role.create(user_id: @user_president.id, club_period_id: @club_period.id, role_type_id: @role_type_president.id)
Role.create(user_id: @user_member.id, club_period_id: @club_period.id, role_type_id: @role_type_member.id)

Profile.create(full_name: @user_advisor.first_name + ' ' + @user_advisor.last_name, user_id: @user_advisor.id)
Profile.create(full_name: @user_president.first_name + ' ' + @user_president.last_name, user_id: @user_president.id)
Profile.create(full_name: @user_member.first_name + ' ' + @user_member.last_name, user_id: @user_member.id)

# System announcement
SystemAnnouncement.create(title: 'Duyuru 1', content: 'bu test amaçlı oluşturulmuş bir duyurudur.', is_view: true, status: :onemli)
SystemAnnouncement.create(title: 'Duyuru 2', content: 'bu test amaçlı oluşturulmuş 2. duyurudur.', is_view: false, status: :genel)
SystemAnnouncement.create(title: 'Duyuru 3', content: 'bu test amaçlı oluşturulmuş 3. duyurudur.', is_view: true, status: :haber)
SystemAnnouncement.create(title: 'Duyuru 4', content: 'bu test amaçlı oluşturulmuş 4. duyurudur.', is_view: true, status: :haber)
SystemAnnouncement.create(title: 'Duyuru 5', content: 'bu test amaçlı oluşturulmuş 5. duyurudur.', is_view: true, status: :onemli)

# Event Status
EventStatus.create(status: 'SKS Admin Onayı Bekleniyor')
EventStatus.create(status: 'SKS Admin Onayladı')
EventStatus.create(status: 'SKS Admin Onaylamadı')
EventStatus.create(status: 'Akademik Danışman Onayı Bekleniyor')
EventStatus.create(status: 'Akademik Danışman Onayladı')
EventStatus.create(status: 'Akademik Danışman Onaylamadı')
EventStatus.create(status: 'Dekan Onayı Bekleniyor')
EventStatus.create(status: 'Dekan Onayladı')
EventStatus.create(status: 'Dekan Onaylamadı')

# New Users
@member1 = User.create(email: 'member1@tbs.com', password: 'member123', user_name: 'member1', ubs_no: 'o55555555', first_name: 'member1', last_name: '')
Profile.create(full_name: 'member1', user_id: @member1.id)
@member2 = User.create(email: 'member2@tbs.com', password: 'member123', user_name: 'member2', ubs_no: 'o66666666', first_name: 'member2', last_name: '')
Profile.create(full_name: 'member2', user_id: @member2.id)
@member3 = User.create(email: 'member3@tbs.com', password: 'member123', user_name: 'member3', ubs_no: 'o77777777', first_name: 'member3', last_name: '')
Profile.create(full_name: 'member3', user_id: @member3.id)
@member4 = User.create(email: 'member4@tbs.com', password: 'member123', user_name: 'member4', ubs_no: 'o88888888', first_name: 'member4', last_name: '')
Profile.create(full_name: 'member4', user_id: @member4.id)
@member5 = User.create(email: 'member5@tbs.com', password: 'member123', user_name: 'member5', ubs_no: 'o99999999', first_name: 'member5', last_name: '')
Profile.create(full_name: 'member5', user_id: @member5.id)
