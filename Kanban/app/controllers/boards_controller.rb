class BoardsController < ApplicationController
  before_action :set_board, only: [:show, :edit, :update, :destroy]
  before_action :user_is_member, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /boards
  # GET /boards.json
  def index
    @boards = Board.all
    redirect_to root_path unless (current_user)
  end

  # GET /boards/1
  # GET /boards/1.json
  def show
    @board = Board.find(params[:id])
    current_user.current_board=params[:id]
  end
  

  # GET /boards/new
  def new
    @board = Board.new
  end

  # GET /boards/1/edit
  def edit
  end
  
  def user_is_member
    @board = Board.find(params[:id])
    redirect_to root_path unless (@board.users.exists?(current_user.id))
  end
  
  def add_member
    @member = User.find(params[:member])
        @board = Board.find(params[:board])
        @board.users.new(@member)

        if current_user.save
            flash[:notice] = "Member was successfully added"
        else
            flash[:danger] = "There was something wrong with the member request"
        end
        redirect_to my_members_path
  end

  # POST /boards
  # POST /boards.json
  def create
    
    
    
    @board = Board.create(board_params)
    @board.update_attributes(:owner_id => current_user.id)
    @board.memberships.new(:user => User.find(current_user.id), :board => @board)
    

    respond_to do |format|
      if @board.save
        format.html { redirect_to @board}
        format.json { render :show, status: :created, location: @board }
      else
        format.html { render :new }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /boards/1
  # PATCH/PUT /boards/1.json
  def update
    respond_to do |format|
      if @board.update(board_params)
        format.html { redirect_to @board}
        format.json { render :show, status: :ok, location: @board }
      else
        format.html { render :edit }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boards/1
  # DELETE /boards/1.json
  def destroy
    @board = Board.find(params[:id])
    @board.destroy
    respond_to do |format|
      format.html { redirect_to boards_url}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_board
      @board = Board.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def board_params
      params.require(:board).permit(:name, :description)
    end
end
