class SessionsController < ApplicationController
    def new
        render :new
    end

    def create
        @user = User.find_by_credentials(params[:user][:email], params[:user][:password])
        if @user.save
            login!(@user)
            @user.reset_session_token!
            session[:session_token] = @user.session_token
            redirect_to user_url(@user.id)
            flash[:messages] = ["Successfully Login!"]
        else
            flash.new[:error] = @user.errors.full_messages
            render :new
        end
    end

    def destroy
        current_user.reset_session_token! if logged_in?
        session[:session_token] = nil
        redirect_to new_user_url
    end
end