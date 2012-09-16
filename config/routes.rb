ActionController::Routing::Routes.draw do |map|

  map.resources :fotos, :users, :projetos
  map.resource :session, :mapa

  # A gente não quer mapear o singup
  # map.signup '/signup', :controller => 'users', :action => 'new'
  map.login '/adm', :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => 'welcome'
  map.connect '', :controller => 'welcome'

  # Controller Projeto Routes
  map.projetos '/projetos', :controller => 'projetos', :action => 'index'
  map.ordena_modelo '/projetos/ordena/:modelo/:coluna/:ordem', :controller => 'projetos', :action => 'ordena_projetos'
  map.ordena_projetos '/projetos/ordena/:coluna/:ordem', :controller => 'projetos', :action => 'ordena_projetos'
  map.busca_endereco '/projetos/show/busca_ed', :controller => 'projetos', :action => 'busca_endereco'
  map.limpa_fotos '/limpa_fotos/:fake_id', :controller => 'projetos', :action => 'limpa_fotos'

  # Rotas para equipe (mostrar e editar)
  map.equipe '/equipe', :controller => 'baccos', :action => 'show'
  map.equipe_edit '/equipe/edit', :controller => 'baccos', :action => 'edit'

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
