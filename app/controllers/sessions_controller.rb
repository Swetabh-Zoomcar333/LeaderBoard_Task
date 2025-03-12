class SessionsController < ApplicationController

  def login
    user = User.find_by(username: params[:username])

    if user
      token = JsonWebToken.encode(user_id: user.id)
      cookies[:jwt] = { value: token, httponly: true }
      render json: { message: 'Logged in successfully' }, status: :ok
    else
      render json: { error: 'Invalid username' }, status: :unauthorized
    end
  end

  def logout
    cookies.delete(:jwt)
    render json: { message: 'Logged out successfully' }, status: :ok
  end
end
