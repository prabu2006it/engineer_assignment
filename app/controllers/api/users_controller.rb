class Api::UsersController < Api::BaseController
  before_action :doorkeeper_authorize!, except: [:sign_up, :sign_in]

  def sign_up
  	@user = User.new(user_params)
  	if @user.save
  	  render json: {success: true}
  	else
  	  render json: {success: false, errors: @user.errors.messages}
  	end
  end

  def sign_in
  	@user = User.where(email: params[:email]).last
  	if @user.present? and @user.valid_password?(params[:password])
  	  token = @user.get_access_token
      render json: {success: true, token: token.token}
  	else
  	  render json: {success: false, errors: "Invalid User"}
  	end
  end

  def add_phone_number
  	number = PhoneNumber.validate_and_generate_number(params[:phone_number])
  	phone_number = current_user.phone_numbers.new(number: number)
  	if phone_number.save
  	  render json: {success: true, message: "created successfully", number: number}
 	else
 	  render json: {success: false, errors: phone_number.errors.messages}
    end
  end

  private 

  def user_params
  	params.require(:user).permit(:email, :password)
  end
end