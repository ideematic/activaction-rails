class WikiPagesController < ApplicationController

  protect_from_forgery :except => [:update]

  def handler
    @url = params[:url] || ''
    @wiki_page = WikiPage.find_by_url @url

    # WikiPage not found
    if !@wiki_page
      if current_user && current_user.is_admin
        @message = "The page <b>#{params[:url]}</b> does not exist".html_safe
        render template: 'wiki_pages/create' # 'pages/handler'
      else
        raise ActionController::RoutingError.new('Not Found')
      end
    else
      if !@wiki_page.public && !user_signed_in?
        session[:my_return_to] = "/wiki/#{@wiki_page.url}"
        redirect_to new_user_session_path, flash: {error: 'Vous devez vous connecter pour voir cette page.'}
      else
        render template: 'wiki_pages/page'
      end
    end
  end

  def create
    @page = WikiPage.create wiki_page_params
    redirect_to "/wiki/#{@page.url}", flash: {notice: 'Page créee'}
  end

  def update
    @page = WikiPage.find params[:id]
    @page.content = wiki_page_params[:content]
    @page.save
    render json: {success: true}
  end

  private

  def wiki_page_params
    params.require(:wiki_page).permit(:url, :content, :public)
  end
end
