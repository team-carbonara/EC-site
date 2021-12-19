class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
<<<<<<< HEAD
  # before_action :aa
=======

  # def after_sign_in_path_for(resource)
  #   if resource.is_a?(Admin)
  #     admin_root_path
  #   else
  #     root_path
  #   end
  # end

  # def after_sign_out_path_for(resource)
  #   if resource == :admin
  #     new_admin_session_path
  #   else
  #     new_customer_session_path
  #   end
  # end

>>>>>>> origin/develop
 protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :post_code, :address, :tel, :email])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
  end

  # def aa
  #   if customer_signed_in?
  #     if  URI.regexp.match('admin')
  #       redirect_to cart_products_path
        
  #     else
  #       redirect_to admin_products_path
      
  #     end
  #   end
  # end

  # def check?(url_string)
  # URI::DEFAULT_PARSER.make_regexp.match(admin).present?
  # end
end
