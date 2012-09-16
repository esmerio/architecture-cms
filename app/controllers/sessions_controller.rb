# This controller handles the login/logout function of the site.
class SessionsController < ApplicationController
  # render new.rhtml
  def new
    if logged_in?
      respond_to do |format|
        format.html { redirect_back_or_default(root_path) }
      end
    else
      respond_to do |format|
        format.html
      end
    end
  end

  def create
    self.current_user = User.authenticate(params[:login], params[:password])
    if logged_in?
      if params[:remember_me] == "1"
        self.current_user.remember_me
        cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
      end
      redirect_back_or_default(root_path)
      flash[:notice] = "Bem vindo, admin!" # Não aparece na página
    else
      flash.now[:notice] = "Usu&aacute;rio n&atilde;o encontrado ou senha inv&aacute;lida."
      render :action => 'new'
    end
  end

  def destroy
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash.now[:notice] = "Tchau!" # Não aparece na página
    respond_to do |format|
      format.html { redirect_back_or_default(root_path) }
      format.js
    end
  end
end
