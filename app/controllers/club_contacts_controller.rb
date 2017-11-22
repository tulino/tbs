class ClubContactsController < ApplicationController
  before_action :set_club_contact, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]

  def index
    @club_contacts = ClubContact.all
    authorize @club_contacts
  end

  def show; end

  def new
    @club_contact = ClubContact.new
    authorize @club_contact
  end

  def edit; end

  def create
    @club_contact = ClubContact.new(club_contact_params)
    authorize @club_contact
    respond_to do |format|
      if @club_contact.save
        format.html { redirect_to @club_contact, notice: 'Topluluk iletişim bilgisi başarıyla oluşturuldu.' }
        format.json { render :show, status: :created, location: @club_contact }
      else
        format.html { render :new }
        format.json { render json: @club_contact.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @club_contact
    respond_to do |format|
      if @club_contact.update(club_contact_params)
        format.html { redirect_to @club_contact, notice: 'Topluluk iletişim bilgisi başarıyla güncellendi.' }
        format.json { render :show, status: :ok, location: @club_contact }
      else
        format.html { render :edit }
        format.json { render json: @club_contact.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @club_contact
    @club_contact.destroy
    respond_to do |format|
      format.html { redirect_to club_contacts_url, notice: 'Topluluk iletişim bilgisi başarıyla silindi.' }
      format.json { head :no_content }
    end
  end

  private

  def set_club_contact
    @club_contact = ClubContact.find(params[:id])
  end

  def club_contact_params
    params.require(:club_contact).permit(:club_id, :address, :email, :phone_number, :face_url, :tw_url, :gplus_url, :youtube_url, :github_url, :linkedin_url)
  end
end
