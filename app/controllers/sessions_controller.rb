class SessionsController < ApplicationController
    def new
    end

    def create
        user = User.find_by_email params[:email] 
        #specifying that we only want to find the user by their email. This is the only unique thing they'll be signing in with, really
        if user&.authenticate(params[:password])
            session[:user_id] = user.id #specify this as the user object contains much more data than we need for authentication
            redirect_to root_path, notice: "Welcome, #{user.name}"
        else
            flash[:alert] = "Incorrect Password or Email"
            render :new
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to root_path, notice: "Goodbye 🖖"
    end

end
