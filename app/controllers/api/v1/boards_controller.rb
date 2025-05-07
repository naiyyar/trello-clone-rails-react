class Api::V1::BoardsController < ApplicationController
  before_action :set_board, only: [:show, :update, :destroy]

  def index
    render json: { data: current_user.boards.rank(:row_order) }
  end

  def show
    switch_board(@board)
    render json: { data: board_data }
  end

  def create
    @board = current_user.boards.new(board_params)
    if @board.save
      switch_board(@board)
      render json: {message: 'Board created successfully', data: board_data }
    else
      render json: {message: 'Error in creating board', error: @board.errors }
    end
  end

  def update
    if @board.update(board_params)
      render json: {message: 'Board successfully updated', data: @board }
    else
      render json: {message: 'Error in updated board', error: @board.errors }
    end
  end

  def destroy
    if @board.destroy
      render json: {message: 'Board successfully deleted', data: @board }
    else
      render json: {message: 'Error in deleted board', error: @board.errors }
    end
  end

  private

  def set_board
    @board = Board.find(params[:id])
  end

  def board_params
    params.require(:board).permit(:name, :user_id, :background, :row_order)
  end

  def board_data
    { board: current_board, lists: current_board.lists.rank(:row_order) }
  end
end
