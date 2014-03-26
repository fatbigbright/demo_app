class SessionsController < ApplicationController
    def new
    end
    def create
        user = User.find_by(email: params[:email].downcase)
        if user && user.authenticate(params[:password])
            sign_in user

            # redirect to user or session[:return_to]
            redirect_back_or user
        else
            # flash will not disappear after refreshing, flash.now will do
            flash.now[:error] = 'Invalid email/password combination'
            render 'new'
        end
    end

    def destroy
        sign_out
        redirect_to root_path
    end
end
