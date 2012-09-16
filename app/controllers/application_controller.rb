# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem

  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '7c1842d3dbbafd9c89cabb6e8405ac61'

  def autoriza
   unless logged_in?
     redirect_to root_path
     false
   end
  end
  
  def cria_linha_projeto(projeto)
    link = "<a href = 'projetos/#{projeto.id}' >" + projeto.nome + "</a>"
    imagem = projeto.destaque
    if (not imagem.nil?)
      foto = "<img class='tiny' src='"+imagem.public_filename(:tiny)+"' alt='"+projeto.nome+"' />"
    else
      foto = ""
    end
    foto + link + "<br/>"
  end

end

class MyVariable < Ym4r::MapstractionPlugin::Variable

  #Overrides the Variable implementation so that add_overlay works without javascript
  def to_s
    create
  end
end