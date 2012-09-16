class ProjetosController < ApplicationController

  before_filter :autoriza, :except => [:index, :show, :ordena_projetos]

  def show
    @projeto = Projeto.find(params[:id])
  end

  def new
    @projeto = Projeto.new
    @projeto.id = -rand(500)
    carrega_atributos_para_adicao_ou_edicao()
  end

  def edit
    @projeto = Projeto.find(params[:id])
    carrega_atributos_para_adicao_ou_edicao()
  end


  def create
    @projeto = Projeto.new(params[:projeto])
    @projeto.fotos = Foto.find(:all, :conditions => ["grupo_de_fotos_id = ?", params[:fake_id]])

    @projeto.local = Local.new
    atualiza_local(@projeto.local, params)

    respond_to do |format|
      if @projeto.save
        flash[:notice] = 'Projeto foi criado com sucesso.'
        format.html { redirect_to(@projeto) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @projeto = Projeto.find(params[:id])

    if @projeto.local.nil?
      @projeto.local = Local.new
    end
    atualiza_local(@projeto.local, params)

    respond_to do |format|
      if @projeto.update_attributes(params[:projeto])
        flash[:notice] = 'Projeto foi atualizado com sucesso.'
        format.html { redirect_to(@projeto) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @projeto = Projeto.find(params[:id])
    @projeto.destroy

    respond_to do |format|
      format.html { redirect_to(projetos_url) }
    end
  end

  def index
    @projetos = Projeto.find(:all)
    @estagios = Estagio.find(:all, :order => 'ordem ASC')
    respond_to do |format|
      format.html
      format.js
    end
  end

  def ordena_projetos
    modelo = params[:modelo]
    coluna = params[:coluna]
    ordem = params[:ordem]
    data = ', data DESC'

    @estagios = Estagio.find(:all, :order => 'ordem ASC')
    if modelo.nil?
        @projetos = Projeto.find(:all, :order => coluna + ' ' + ordem + data)
    else
        @projetos = Projeto.find(:all, :include => modelo, :order => modelo + 's.' + coluna + ' ' + ordem + data)
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  # /projetos/show/busca_ed/:endereco
  def busca_endereco
    @markers = []

    address_list = lookup_geocodes(params[:endereco])
    @map = new_map
    icon = MyVariable.new("icon_incident")

    unless address_list.nil?
      address_list.each do |marker|
        @latitude = marker[:latitude]
        @longitude = marker[:longitude]
        marker = GMarker.new([marker[:latitude],marker[:longitude]], :icon => icon, :draggable => true)
        @markers << marker
      end

      @center = GLatLng.new(bounding_box_center(@markers))
    end

    respond_to do |format|
      format.js do
        responds_to_parent do
          render :update do |page|
            page << @map.clear_overlays
            @markers.each do |marker|
              page << marker.declare("my_marker")
              page << @map.add_overlay(marker)
              page << marker.on_dragend("atualiza_pos")
              page << "document.getElementById('latitude').value="+marker.point.lat.to_s
              page << "document.getElementById('longitude').value="+marker.point.lng.to_s
            end
            page << @map.set_center(@center,12)
          end
        end
      end
    end
  end

  #Métodos que encontram um endreço e devolvem

  def lookup_geocodes(address = nil)
    places = [
       {:address => address, :description=>'search'}]
      places.collect do |place|
        geocode = get_geocode place[:address]
        place[:latitude]=geocode[:latitude]
        place[:longitude]=geocode[:longitude]
      end
      return places
    end

  def limpa_fotos
    fotos = Foto.find_all_by_grupo_de_fotos_id(params[:fake_id])
    fotos.each do |foto|
      thumb = Foto.find_by_parent_id(foto.id)
      thumb.destroy
      foto.destroy
    end

    respond_to do |format|
      format.html {redirect_to(projetos_path)}
    end
  end


  private
  def cria_mapa_para(local)
    if local.nil? or local.latitude.nil? or local.longitude.nil?
      @map = new_map
    else
      @map = new_map(local.latitude, local.longitude, 9)
      icon = MyVariable.new("icon_incident")
      marker = pega_marker_do_local(icon, local)
      @map.overlay_global_init(marker,"my_marker")
      @map.event_init(marker,"dragend","atualiza_pos")
    end
  end

  def bounding_box_center(markers)
    maxlat, maxlng, minlat, minlng = -Float::MAX, -Float::MAX, Float::MAX, Float::MAX
    markers.each do |marker|
      coord = marker.point
      maxlat = coord.lat if coord.lat > maxlat
      minlat = coord.lat if coord.lat < minlat
      maxlng = coord.lng if coord.lng > maxlng
      minlng = coord.lng if coord.lng < minlng
    end
    return [(maxlat + minlat)/2,(maxlng + minlng)/2]
  end


  def get_geocode(address)
     geocode = Geocoding.get(address)
     return {:success=> true, :latitude=> geocode[0][:latitude],
       :longitude=> geocode[0][:longitude]}
  end

  def new_map(lat=-6.489983332670638,long=-62.2265625,zoom=3)
    @map = GMap.new("mapa_div")
    @map.control_init(:large_map => true, :map_type => true)
    @map.center_zoom_init([lat,long],zoom)
    @map.icon_global_init(GIcon.new(:image => "/images/amarelo.png", :icon_size => GSize.new(15,15),:icon_anchor => GPoint.new(7,7),:info_window_anchor => GPoint.new(9,2)),"icon_incident")

    @map
  end

  def pega_marker_do_local(icon,local)
    latitude = local.latitude
    longitude = local.longitude
    marker = GMarker.new([latitude,longitude], :icon => icon , :title => local.endereco, :draggable => true)
    marker
  end

  def carrega_atributos_para_adicao_ou_edicao
    @categorias = Categoria.find(:all)
    @estagios = Estagio.find(:all)
    @foto = Foto.new
    @foto.grupo_de_fotos = @projeto
    cria_mapa_para(@projeto.local)
  end

  def atualiza_local(local, params)
    local.endereco = params[:endereco_falso] unless params[:endereco_falso].blank?
    local.latitude = params[:latitude] unless params[:latitude].blank?
    local.longitude = params[:longitude] unless params[:longitude].blank?
    local.save
  end

end
