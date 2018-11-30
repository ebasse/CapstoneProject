class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all
    @board = Board.find(params[:board_id])
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @board = Board.find(params[:board_id])
  end
  
  def ajax_show
    @task = Task.find(params[:id])
    ret = {'board_id' => @task.board_id}
    respond_to do |format|
      format.html
      format.json { render json: ret }
    end
    
  end

  # GET /tasks/new
  def new
    @board = Board.find(params[:board_id])
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
    @board = Board.find(@task.board_id)
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @board = Board.find(params[:board_id])
    @task = @board.tasks.create(task_params)
    @task.update_attributes(:x => 10, :y => 30)
    redirect_to board_path(@board)
=begin
    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
=end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    @board = Board.find(params[:board_id])
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to board_task_path, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @board = Board.find(@task.board_id)
    @task.destroy
    respond_to do |format|
      format.html { redirect_to @board, notice: 'Task was successfully deleted.' }
      format.json { head :no_content }
    end
  end
  
  def get_pos
    @task = Task.find(params[:id])
    ret = {"new_x" => @task.x, "new_y" => @task.y}
    respond_to do |format|
      format.html
      format.json {render json: ret}
    end
  end
  
  def update_pos
    @task = Task.find(params[:id])
    @task.update_attributes(:x => params[:newX], :y => params[:newY])
    #@task.x = params[:x]
    #@task.y = params[:y]
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:name, :description)
    end
end
