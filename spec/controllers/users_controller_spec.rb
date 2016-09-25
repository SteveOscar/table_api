require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  let(:valid_attributes) {
    {
      name: 'steve',
      email: 'fake@email.com',
      device: 1243
    }
  }

  let(:invalid_attributes) {
    {
      email: 'fake@email.com',
      device: 1243
    }
  }

  let(:invalid_attributes2) {
    {
      email: 'fake@email.com',
      name: 'steve'
    }
  }

  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all users as @users" do
      user = User.create! valid_attributes
      get :index, {}, valid_session
      result = JSON.parse(response.body)[0]
      expect(result ['name']).to eq(user.name)
    end
  end

  describe "GET show" do
    it "assigns the requested user as @user" do
      user = User.create! valid_attributes
      get :show, {:id => user.to_param}, valid_session
      result = JSON.parse(response.body)
      expect(result ['name']).to eq(user.name)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new User" do
        expect {
          post :create, {:user => valid_attributes}, valid_session
        }.to change(User, :count).by(1)
      end

      it "assigns a newly created user as @user" do
        post :create, {:user => valid_attributes}, valid_session
        expect(User.first).to be_a(User)
        expect(User.first).to be_persisted
      end
    end

    describe "with invalid params" do
      it "cant create with no name" do
        post :create, {:user => invalid_attributes}, valid_session
        expect(User.first).to be(nil)
        expect(JSON.parse(response.body)['name'].first).to eq("can't be blank")
      end

      it "cant create with no device" do
        post :create, {:user => invalid_attributes2}, valid_session
        expect(User.first).to be(nil)
        expect(JSON.parse(response.body)['device'].first).to eq("can't be blank")
      end

      it "cant duplicate name" do
        User.create! valid_attributes
        post :create, {:user => valid_attributes}, valid_session
        expect(JSON.parse(response.body)['name'].first).to eq("has already been taken")
      end

      it "cant duplicate device" do
        User.create! valid_attributes
        post :create, {:user => valid_attributes}, valid_session
        expect(JSON.parse(response.body)['device'].first).to eq("has already been taken")
      end
    end
  end

end
