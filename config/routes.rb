Bacco::Application.routes.draw do
  resources :fotos
  resources :users
  resources :projetos
  resource :session
  resource :mapa
  match '/adm' => 'sessions#new', :as => :login
  match '/logout' => 'sessions#destroy', :as => :logout
  match '/' => 'welcome#index', :as => :root
  match '/offices/edita_projeto_mes' => 'welcome#muda_projeto_mes'
  match '/offices/autocomplete_projeto' => 'welcome#auto_complete_for_projeto_nome'
  match '/projetos' => 'projetos#index', :as => :projetos
  match '/projetos/ordena/:modelo/:coluna/:ordem' => 'projetos#ordena_projetos', :as => :ordena_modelo
  match '/projetos/ordena/:coluna/:ordem' => 'projetos#ordena_projetos', :as => :ordena_projetos
  match '/projetos/show/busca_ed' => 'projetos#busca_endereco', :as => :busca_endereco
  match '/limpa_fotos/:fake_id' => 'projetos#limpa_fotos', :as => :limpa_fotos
  match '/equipe' => 'offices#show', :as => :equipe
  match '/equipe/edit' => 'offices#edit', :as => :equipe_edit
end
