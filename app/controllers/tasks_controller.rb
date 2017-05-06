class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    #@tasks = Task.all
    json_resp = {}
    date_str = "06 Apr 2016"
    str_date = date_str.to_datetime
    current_date = Date.today
    sixth_date = str_date + 430.days
    seventh_date = str_date + 530.days
    last_service = "02 May 2017".to_datetime
    json_resp = {
      model: 'FZ S V2',
      buy_date: stringFormat(str_date),
      last_service: {
        date: stringFormat(last_service),
        days_past: Date.today - last_service
      },
      next_service: {
        date: stringFormat(sixth_date),
        days_left: sixth_date - Date.today
      },
      future_service: {
        date: stringFormat(seventh_date),
        days_left: seventh_date - Date.today
      }
    }
    render json: json_resp
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
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
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:title, :completed, :order)
    end

    def stringFormat date
      return date.strftime('%d/%b/%Y')
    end
end
