class UsersController < ApplicationController
  before_action :set_user, only: [:update, :destroy]
  before_action :authenticate_request!, only: [:index]

  # GET /users
  # GET /users.json
  def index
    users = User.all
    render json: users
  end

  # GET /users/1
  # GET /users/1.json
  def show
    user = User.find_by(uid: params[:id])
    if user
      puts 'USER FOUND'
      render json: user
    else
      puts 'NO USER'
      render json: 'no user'.to_json
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.registration_confirmation(@user).deliver
      render json: {status: 'User created successfully'}, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :bad_request
    end
  end

  def login
    user = User.find_by(email: params[:email].to_s.downcase)

    if user && user.email_confirmed && user.authenticate(params[:password])
        auth_token = JsonWebToken.encode({user_id: user.id})
        render json: user.attributes.slice('id', 'email').merge({auth_token: auth_token}), status: :ok
    elsif user && !user.email_confirmed
      puts 'UNCOMFIRMED EMAIL'
      render json: {error: 'Account confirmation required, check your email.'}, status: :unauthorized
    else
      puts 'BAD CREDENTIALS'
      render json: {error: 'Invalid username / password'}, status: :unauthorized
    end
  end

  def confirm_email
    user = User.find_by(confirm_token: params[:format])
    if user
      user.email_activate
      render html: '<div>Your TableGrab account has been confirmed. Please sign in on the mobile app.</div>'.html_safe
    else
      render html: '<div>Unable to find an account to verify based on this link.</div>'.html_safe
    end
end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:uid, :username, :zip, :location, :tables, :password, :password_confirmation, :email, :id)
    end

end
