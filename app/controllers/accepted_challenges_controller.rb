class AcceptedChallengesController < ApplicationController
  before_action :set_accepted_challenge, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_player!

  def index
    @player = Player.find_by_id(params[:player_id]) || current_player
    @accepted_challenges = @player.accepted_challenges
  end

  def show
  end

  def new
    AcceptedChallenge.create!(challenge_id: params[:challenge_id], player_id: params[:player_id], active: params[:active])
    redirect_to back_or(accepted_challenges_url), notice: 'You have accepted this challenge.'
  end

  def edit
  end

  def update
    respond_to do |format|
      if @accepted_challenge.update(accepted_challenge_params)
        format.html { redirect_to accepted_challenges_url, notice: 'Accepted challenge was successfully updated.' }
        format.json { render :show, status: :ok, location: @accepted_challenge }
      else
        format.html { render :edit }
        format.json { render json: @accepted_challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @accepted_challenge.destroy
    respond_to do |format|
      format.html { redirect_to accepted_challenges_url, notice: 'Accepted challenge was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_accepted_challenge
      @accepted_challenge = AcceptedChallenge.find(params[:id])
    end

    def accepted_challenge_params
      params.require(:accepted_challenge).permit(:player_id, :challenge_id, :active, :comments, :starting, :ending)
    end
end
