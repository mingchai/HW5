class ApplicationController < ActionController::Base
    private
    def current_user
        if session[:user_id].present?
            @current_user ||= User.find_by_id session[:user_id]
        end
    end
    helper_method :current_user

    def signed_in?
        current_user.present?
    end
    helper_method(:signed_in?)

    def authenticated_user!
        unless signed_in?
            flash[:alert] = "Please sign up or sign in" 
            redirect_to new_session_path
        end
    end
end
