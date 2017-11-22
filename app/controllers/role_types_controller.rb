class RoleTypesController < ApplicationController
  before_action :set_role_type, only: [:show, :edit, :update, :destroy]

  def index
    @role_types = RoleType.all
  end

  def show; end

  def new
    @role_type = RoleType.new
  end

  def edit; end

  def create
    @role_type = RoleType.new(role_type_params)
    respond_to do |format|
      if @role_type.save
        format.html { redirect_to @role_type, notice: 'Rol tipi başarıyla oluşturuldu.' }
        format.json { render :show, status: :created, location: @role_type }
      else
        format.html { render :new }
        format.json { render json: @role_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @role_type.update(role_type_params)
        format.html { redirect_to @role_type, notice: 'Rol tipi başarıyla güncellendi.' }
        format.json { render :show, status: :ok, location: @role_type }
      else
        format.html { render :edit }
        format.json { render json: @role_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @role_type.destroy
    respond_to do |format|
      format.html { redirect_to role_types_url, notice: 'Rol tipi başarıyla silindi.' }
      format.json { head :no_content }
    end
  end

  private

  def set_role_type
    @role_type = RoleType.find(params[:id])
  end

  def role_type_params
    params.require(:role_type).permit(:name)
  end
end
