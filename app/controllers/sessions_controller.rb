class SessionsController < ApplicationController

  def login
    user = User.find_by(username: params[:username])

    if user
      token = JsonWebToken.encode(user_id: user.id)
      cookies[:jwt] = { value: token, httponly: true }
      render json: { message: 'Logged in successfully' }, status: 200
    else
      render json: { error: 'Invalid username' }, status: 401
    end
  end

  def logout
    cookies.delete(:jwt)
    render json: { message: 'Logged out successfully' }, status: 200
  end
end
