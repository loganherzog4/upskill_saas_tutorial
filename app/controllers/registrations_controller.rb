class RegistrationsController < Devise::RegistrationsController
    
    prepend_before_action :check_captcha, only: [:create]
    
    private
        def check_captcha
            unless verify_recaptcha
                self.resource = resource_class.new sign_up_params
                resource.validate # Look for any other validation errors besides reCAPTCHA
                set_minimum_password_length
                respond_with_navigation(resource) {render :new}
            end
        end
    
end
