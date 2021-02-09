class Users::RegistrationsController < Devise::RegistrationsController
    prepend_before_action :check_captcha, only: [:create]
    before_action :select_plan, only: :new
    
    # Extend default Devise gem behavior so that users signing up with the Pro 
    # account save with a special Stripe subscription function.
    # Otherwise, Devise signs up user as usual.
    def create
        
       super do |resource|
           if params[:plan]
               resource.plan_id = params[:plan]
               
               if resource.plan_id == 2
                    resource.save_with_subscription
                else
                    resource.save
                end
            end
        end
    end
    
    private
        def select_plan
            unless (params[:plan] == '1' || params[:plan] == '2')
                flash[:notice] = "Please select a valid membership plan."
                redirect_to root_path
            end
        end
        
        def check_captcha
          unless verify_recaptcha
            self.resource = resource_class.new sign_up_params
            resource.validate # Look for any other validation errors besides reCAPTCHA
            set_minimum_password_length
            respond_with_navigational(resource) { render :new }
          end 
        end
end