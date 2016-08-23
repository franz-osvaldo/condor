class TasksController < ApplicationController
  def index
    @system = System.find(params[:system_id])
    @tasks = @system.tasks
    @task = Task.new
    flash.now[:aircrafts] = 'in'
  end

  def new_field
    @tool = Tool.find(params[:id])
    respond_to do |format|
      format.js{}
    end
  end

  def new_product_field
    @product = Product.find(params[:id])
    respond_to do |format|
      format.js{}
    end
  end

  def create
    # render :text => params.inspect
    @system = System.find(params[:system_id])
    @task = Task.new(task_params)
    @task.system = @system
    respond_to do |format|
      if @task.save
        format.js {}
      else
        format.js {}
      end
    end
  end
  private
  def task_params
    params.require(:task).permit(:name, :task_number, :tool_ids => [], :product_ids => [])
  end
end

