class Api::V1::SessionsController < Devise::SessionsController
  prepend_before_action :destroy_session
  respond_to :json
  swagger_controller :sessions, 'Sessions'
  
  # POST /session/sign_in
  swagger_api :create do
    summary 'Returns a token after sign in.'
    param :form, "login", :string, :required, "Username of the user logging in"
    param :form, "password", :string, :required, "Matching password of the above username"
    response :not_found
  end
  def create    
    user = warden.authenticate!(auth_options)
    token = Tiddle.create_and_return_token(user, request)
    render json: {authentication_token: token, user_id: user.id }, status: 201
  end
  swagger_api :destroy do
    summary "Sign out a signed in user"
    param :path, :id, :integer, :optional, "User Id"
    response :unauthorized
    response :not_found
  end
  def destroy
    Tiddle.expire_token(current_user, request) if current_user
    render json: {}
  end
end