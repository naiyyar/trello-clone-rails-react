class Api::V1::BoardInvitationsController < ApplicationController
  before_action :authenticate_user!

  def create
    @board = Board.find(params[:board_id])
    invitation = @board.board_invitations.new(invitation_params)
    invitation.user = current_user
    invitation.status = :pending

    respond_to do |format|
      if invitation.save
        BoardInvitationMailer.invite_email(invitation).deliver_now
        message = "Invitation sent"      
      else
        message = invitation.errors.messages
      end
    end
    render json: { message: message }
  end

  def accept
    invitation = BoardInvitation.find_by(token: params[:token])
    
    if invitation&.pending?
      user = User.find_by(email: invitation.email)
      if user
        invitation.update(user: user, status: :accepted)
        message = "You have joined the board!"
      else
        message = "Invalid invitation."
      end
    else
      message = "Invitation is no longer valid."
    end
    render json: {message: message}
  end

  def reject
    invitation = BoardInvitation.find_by(token: params[:token])
    
    if invitation&.pending?
      user = User.find_by(email: invitation.email)
      if user
        invitation.update(user: user, status: :rejected)
        message = "Rejected"
      else
        message = "Invalid invitation."
      end
    else
      message = "Invitation is no longer valid."
    end
    render json: { message: message }
  end

  private

  def invitation_params
    params.expect(board_invitation: [ :email ])
  end
end
