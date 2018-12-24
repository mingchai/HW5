class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def create
        @user = User.new user_params

        if @user.save
            session[:user_id] = @user.id
            redirect_to root_path
        else
            render :new
        end
    end
 
    def edit
        @user = User.find params[:id]
        # render json: params
        # {
        #   "controller": "users",
        #   "action": "edit",
        #   "id": "1"
        # }
    end

    def update
        @user = User.find params[:id]
        if @user.update user_params
            redirect_to root_path
        else
            render :edit
        end

    end

    def edit_password
        @user = User.find params[:id]
    end

    def update_password
        @user = User.find params[:id]
        # render json: params
        # {
        #     "utf8": "✓",
        #     "_method": "patch",
        #     "authenticity_token": "Vz6YjsQlt63v0GI5fXsatH28bWKoFdwSwrab3TGg+4vERek5XCcveBkv0flcbT5/XlsxjSC/4K3biMxgIlQ6GA==",
        #     "current_password": "~",
        #     "password": "1",
        #     "password_confirmation": "1",
        #     "commit": "Update Password",
        #     "controller": "users",
        #     "action": "update_password",
        #     "id": "1"
        # }

        if params[:current_password] == params[:password]
            flash[:danger] = "New Password matches Current Password"
            render :edit_password
            
        elsif params[:current_password] != params[:password] && params[:password] == params[:password_confirmation]
            flash[:primary] = "Password Updated!"
            @user.update edit_password_params
            redirect_to edit_password_path
        end
    end

    private
    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def edit_password_params
        params.permit(:password, :password_confirmation)
    end
    
end
