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
    if params[:user][:section] == 'private-info'
      @user = User.find(params[:id])
      if @user.update_attributes(parse_user_params user_params)
        flash.now[:success] = 'Informations enregistrées.'
      else
        @section = 'private'
        flash.now[:error] = 'Impossible d\'enregistrer. Merci de corriger les erreurs.'
      end
    elsif params[:user][:section] == 'public-info'

    end
    render 'show'
  end

  private
  def parse_user_params(user_params)
    user_params[:newsletter_at] = user_params[:newsletter_at] == '1' ? Time.now : nil
    user_params[:birthdate] = Date.new(*user_params[:birthdate].split('/').reverse.map(&:to_i)) rescue nil
    user_params
  end

  def user_params
    params.require(:user).permit(:user_id, :email, :first_name, :last_name, :gender, :bio, :username, :terms_at,
                                 :newsletter_at, :city_id, :birthdate, :studies, :desired_job, :professional_experiences,
                                 :education)
  end
end