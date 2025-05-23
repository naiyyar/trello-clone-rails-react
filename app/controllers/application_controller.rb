class ApplicationController < ActionController::API
  include RackSessionFix
  include ActionController::Helpers

  before_action :set_current_board, if: :user_signed_in?

  helper_method :current_board

  

  private

  def set_current_board
    @current_board ||= begin 
      current_user.boards.find(session[:current_board_id] || params[:board_id])
    rescue 
      current_user.boards.first
    end
  end

  def current_board
    @current_board
  end

  def switch_board(board)
    session[:current_board_id] = board.id
    @current_board = board
  end
end
