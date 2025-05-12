class Api::V1::BoardInvitationsController < ApplicationController
  # before_action :authenticate_user!

  def create
    @board = Board.find(invitation_params[:board_id])
    invitation = @board.board_invitations.new(invitation_params)
    invitation.user = current_user

    if invitation.save
      BoardInvitationMailer.invite_email(invitation).deliver_now
      invitation.update(status: :sent)
      message = 'Invitation sent'     
    else
      message = invitation.errors.messages
    end
    render json: { message: message }
  end

  def accept
    invitation = BoardInvitation.find_by(token: params[:token])
    
    if invitation&.sent?
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

  # TODO: Later
  # reject link in email
  def reject
    invitation = BoardInvitation.find_by(token: params[:token])
    
    if invitation&.sent?
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
    params.expect(board_invitation: [ :email, :board_id ])
  end
end
