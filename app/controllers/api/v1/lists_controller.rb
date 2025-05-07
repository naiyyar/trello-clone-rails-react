class Api::V1::ListsController < ApplicationController
  before_action :set_list, only: [:show, :update, :destroy]

  def index
    render json: { data: current_board.lists.rank(:row_order) }
  end

  def show
    render json: { data: @list, tasks: @list.tasks.rank(:row_order) }
  end

  def create
    list = current_board.lists.build(list_params)

    if list.save
      render json: {message: 'list created successfully', data: list }
    else
      render json: {message: 'Error in creating list', error: list.errors }
    end
  end

  def update
    if @list.update(list_params)
      render json: {message: 'list successfully updated', data: @list }
    else
      render json: {message: 'Error in updated list', error: @list.errors }
    end
  end

  def destroy
    if @list.destroy
      render json: {message: 'list successfully deleted', data: @list }
    else
      render json: {message: 'Error in deleted list', error: @list.errors }
    end
  end

  private

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name, :board_id, :row_order)
  end

end
