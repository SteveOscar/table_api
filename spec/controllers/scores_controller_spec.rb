require 'rails_helper'

RSpec.describe ScoresController, :type => :controller do
  let(:valid_attributes) {
    {
      score: 20,
      user_id: Us
    }
  }

  let(:valid_user_attributes) {
    {
      name: 'steve',
      email: 'fake@email.com',
      device: 1243
    }
  }
  let(:valid_user_attributes2) {
    {
      name: 'carl',
      email: 'fake@email2.com',
      device: 2375
    }
  }

  let(:valid_session) { {} }

  describe "GET high scores" do
    it "pulls the high scores" do
      User.create! valid_user_attributes
      score = User.first.scores.create(score: 22)
      score = User.last.scores.create(score: 10)
      score = User.last.scores.create(score: 32)
      score = User.first.scores.create(score: 9)
      score = User.first.scores.create(score: 82)
      get :high_scores, {}, valid_session
      result = JSON.parse(response.body)
      expect(result.length).to eq(5)
      expect(result.last['score']).to eq(82)
    end
  end

  describe "POST score" do
    it "creates a high score" do
      User.create! valid_user_attributes
      post :create, {user_id: User.first.id, device: User.first.device, score: 99}, valid_session
      result = JSON.parse(response.body)
      expect(result['score']).to eq(99)
    end
  end

end
