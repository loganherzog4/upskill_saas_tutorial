class ProfilesController < ApplicationController
    
    # GET request to /users/:user_id/profile/new.
    def new
        
        # Render blank profile details form.
        @profile = Profile.new
        
    end
    
    # POST request to /users/:user_id/profile.
    def create
        
        # Ensure that we have the user who is filling out form.
        @user = User.find(params[:user_id])
        
        # Create profile linked to this specific user.
        @profile = @user.build_profile(profile_params)
        
        if @profile.save
            flash[:success] = "Profile updated."
            redirect_to user_path(params[:user_id])
        else
            render action: :new
        end
        
    end
    
    # GET request to /users/:user_id/profile/edit
    def edit
        
        @user = User.find(params[:user_id])
        @profile = @user.profile
        
    end
    
    # PUT request to users/:user_id/profile
    def update
        
        # Retrieve the user from the database.
        @user = User.find(params[:user_id])
        
        # Retrieve that user's profile.
        @profile = @user.profile
        
        # Mass assign edited profile attributes and save/update.
        if @profile.update_attributes(profile_params)
            flash[:success] = "Profile updated!"
            redirect_to user_path(params[:user_id])
        else
            render action: :edit
        end
        
    end
    
    private
        # To collect data from form, we need to use strong parameters and whitelist the form fields.
        def profile_params
            params.require(:profile).permit(:first_name, :last_name, :avatar, :job_title, :phone_number, :contact_email, :description)
        end
    
end