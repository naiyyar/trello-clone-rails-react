class Api::V1::BoardsController < ApplicationController
  before_action :set_board, only: [:show, :update, :destroy]

  def index
    render json: {data: Board.all }
  end

  def show
    render json: {data: @board }
  end

  def create
    board = Board.new(board_params)
    board.user = current_user

    if board.save
      render json: {message: 'Board created successfully', data: board }
    else
      render json: {message: 'Error in creating board', error: board.errors }
    end
  end

  def update
    if @board.update(board_params)
      render json: {message: 'Board successfully updated', data: board }
    else
      render json: {message: 'Error in updated board', error: board.errors }
    end
  end

  def destroy
    if @board.destroy
      render json: {message: 'Board successfully deleted', data: board }
    else
      render json: {message: 'Error in deleted board', error: board.errors }
    end
  end

  private

  def set_board
    @board = Board.find(params[:id])
  end

  def board_params
    params.require(:board).permit(:name, :user_id, :background, :row_order)
  end
end
