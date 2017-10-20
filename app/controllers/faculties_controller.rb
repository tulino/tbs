class FacultiesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :update, :create, :destroy]

  def index
    @faculties = Faculty.all
    authorize @faculties
  end

  def update
    @faculty = Faculty.find(params[:id])
    authorize @faculty
    @faculty.name = params[:faculty][:name]
    @faculty.save

    redirect_to :back
  end

  def create
    @faculty = Faculty.new
    authorize @faculty
    @faculty.name = params[:faculty][:name]
    @faculty.save
    redirect_to :back
  end

  def destroy
    @faculty = Faculty.find(params[:id])
    authorize @faculty
    @faculty.destroy
    redirect_to :back
  end
end
