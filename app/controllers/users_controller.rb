class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def show
    @user = User.find(params[:id])
    if params[:preview]
      flash.now[:info] = "Vous regardez votre profil du point de vue d'un autre utilisateur.".html_safe +
        " <a href='#{user_path current_user}'>Retour</a>".html_safe
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  def update
    @section = nil
    @user = User.find(params[:id])
    @section = params[:user][:section]
    # binding.pry
    if @user.update_attributes(User.permit_params params)
      flash[:success] = 'Informations enregistrées.'
      redirect_to user_path @user
    else
      flash[:error] = 'Impossible d\'enregistrer. Merci de corriger les erreurs.'
      render 'show'
    end
  end

end