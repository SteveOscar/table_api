class ScoresController < ApplicationController
  before_action :set_user, only: [:create]

  def high_scores
    @scores = Score.order('score').limit(5)
    render json: @scores
  end

  # POST /users
  # POST /users.json
  def create
    @score = @user.scores.new(score: score_params['score'])

    if @score.save
      render json: @score
    else
      render json: @score.errors, status: :unprocessable_entity
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(score_params['user_id'])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def score_params
      params.permit(:score, :user_id, :device)
    end
end
