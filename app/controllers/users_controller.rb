class UsersController < ApplicationController
    
    before_action :authenticate_user!
    
    def index
        @users = User.includes(:profile)
    end
    
    # GET request to /users/:id
    def show
        @user = User.find(params[:id])
    end
    
    # PATCH request to /users/:id/verify
    def verify
        @user = User.find(params[:id])
        @profile = User.profile
        @profile.verified = true
    end
    
end
