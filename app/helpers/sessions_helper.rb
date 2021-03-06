module SessionsHelper
    def sign_in(user)
        remember_token = User.new_remember_token
        cookies.permanent[:remember_token] = remember_token
        user.update_attribute(:remember_token, User.encrypt(remember_token))
        self.current_user = user
    end

    def signed_in?
        # read ! as "bang"
        !current_user.nil?
    end

    def sign_out
        self.current_user = nil
        cookies.delete(:remember_token)
    end

    # attr_accessor, just like setter/getter in C#
    def current_user=(user)
        @current_user = user
    end
    def current_user
        remember_token = User.encrypt(cookies[:remember_token])

        # ||= stands for only when @current_user is not defined, assign user to it
        @current_user ||= User.find_by(remember_token: remember_token)
    end
    def current_user?(user)
        user == current_user
    end

    def redirect_back_or(default)
        redirect_to(session[:return_to] || default)
        session.delete(:return_to)
    end

    def store_location
        session[:return_to] = request.fullpath if request.get?
    end

    def signed_in_user
        unless signed_in?
            store_location
            # just the same as flash[:notice] = "Please sign in."
            redirect_to signin_url, notice: "Please sign in." 
        end
    end
end
