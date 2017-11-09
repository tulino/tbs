class ProfilesController < ApplicationController
  def show
    @profile = Profile.find(params[:id])
    @member_clubs = @profile.user.roles.map { |r| r.club_period.club if r.club_period.present? && r.aktif? && r.role_type.member?}.compact
    authorize @profile
  end

  def update
    @profile = Profile.find(params[:id])
    @params = params.require(:profile).permit(:phone, :adress, :email, :id)
    @profile.phone = params[:profile][:phone]
    @profile.email = params[:profile][:email]
    @profile.adress = params[:profile][:adress]
    @profile.save ? flash[:success] = 'Profil başarıyla güncellenmiştir' : flash[:error] = 'Profil güncellenirken hata oluştu, yeniden deneyiniz'
    redirect_to :back
    authorize @profile
  end
end
