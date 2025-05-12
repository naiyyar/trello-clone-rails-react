class Api::V1::TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: %i[ update destroy ]


  def create
    task = Task.new(task_params)
    task.list_id = task_params[:list_id]
    
    if task.save
      render json: {message: 'Task created successfully', data: task }
    else
      render json: {message: 'Error in creating task', error: task.errors }
    end
  end

  def update
   if @task.update(task_params)
      render json: {message: 'Task updated successfully', data: @task }
    else
      render json: {message: 'Error in updating task', error: @task.errors }
    end
  end

  def destroy
    if @task.destroy
      render json: {message: 'Task successfully deleted', data: @task }
    else
      render json: {message: 'Error in deleted Task', error: @task.errors }
    end
  end

  private

  def set_task
    @task = Task.find(params.expect(:id))
  end

  def task_params
    params.expect(task: [ :title, :list_id ])
  end
end
