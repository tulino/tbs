class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy, :vote]
  before_action :set_selection
  helper_method :did_vote?

  include ListsHelper

  # GET /lists
  # GET /lists.json
  def index
    @lists = List.all
  end

  # GET /lists/1
  # GET /lists/1.json
  def show
  end

  # GET /lists/new
  def new
    @list = List.new
  end

  # GET /lists/1/edit
  def edit
  end

  # POST /lists
  # POST /lists.json
  def create
    new_list_params = list_params.merge(selection_id: @selection.id)
    @list = List.new(new_list_params)

    respond_to do |format|
      if @list.save
        format.html { redirect_to selection_lists_path(@selection), notice: 'List was successfully created.' }
        format.json { render :show, status: :created, location: @list }
      else
        format.html { render :new }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lists/1
  # PATCH/PUT /lists/1.json
  def update
    respond_to do |format|
      if @list.update(list_params)
        format.html { redirect_to @list, notice: 'List was successfully updated.' }
        format.json { render :show, status: :ok, location: @list }
      else
        format.html { render :edit }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lists/1
  # DELETE /lists/1.json
  def destroy
    @list.destroy
    respond_to do |format|
      format.html { redirect_to selection_lists_path(@selection), notice: 'List was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def vote
    authorize @list
    voter = Voter.new(user: current_user, list: @list)
    respond_to do |format|
      if voter.save
        format.html { redirect_to :back, notice: 'Oy Verdiniz' }
      else
        format.html { redirect_to :back }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    
    def set_list
      @list = List.find(params[:id])
    end

    def set_selection
      @selection = Selection.find(params["selection_id"])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def list_params
      params.require(:list).permit(:president_id, :vice_president_id, :accountant_id, :secretary_id, :member_one, :member_two, :member_three, :vote_count, :selection_id)
    end
end
