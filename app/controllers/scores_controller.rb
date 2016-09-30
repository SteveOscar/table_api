class ScoresController < ApplicationController
  before_action :set_user, only: [:create]
  before_action :clean_data, only: [:high_scores]

  def high_scores
    results = {}
    scores = Score.order('score').limit(5)
    results['high_scores'] = scores.map { |s| [s.user.name, s.score] }
    results['user_score'] = User.find_by(device: params['device']).scores.order('score').last.score
    render json: results
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
    def clean_date
      Score.where(user_id: nil).delete_all
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(score_params['user'])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def score_params
      params.permit(:score, :user, :device)
    end
end
