class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params
    before_action :configure_permitted_parameters


  protected

  def customer_state
  ## 【処理内容1】 入力されたemailからアカウントを1件取得
    @customer = Customer.find_by(email: params[:customer][:email])
  ## アカウントを取得できなかった場合、このメソッドを終了する
    return if !@customer
  ## 【処理内容2】 取得したアカウントのパスワードと入力されたパスワードが一致してるかを判別
    if @customer.valid_password?(params[:customer][:password]) && !@customer.is_vaild
      redirect_to new_customer_session_path
    end
  end
end
