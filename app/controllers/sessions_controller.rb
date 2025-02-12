class SessionsController < ApplicationController
    def new
        @user = User.new
    end

    def create
        @user = User.find_by(name: params[:user][:name])
        return head(:forbidden) unless @user.authenticate(params[:user][:password])
        session[:user_id] = @user.id
        redirect_to '/'
    end

    private
    def sessions_params
        params.require(:user).permit(:name, :password, :password_confirmation)
    end
end