class MapasController < ApplicationController

  def show
    @map = GMap.new("mapa_div")
    @map.control_init(:large_map => true, :map_type => true)
    @map.center_zoom_init([-6.489983332670638, -62.2265625],3)
    @map.icon_global_init(GIcon.new(:image => "/images/amarelo.png", :icon_size => GSize.new(15,15),:icon_anchor => GPoint.new(7,7),:info_window_anchor => GPoint.new(9,2)),"icon_incident")

    icon = MyVariable.new("icon_incident")
    @markers = pega_markers_de_todos_locais(icon)
    @markers.each do |marker|
      @map.overlay_init(marker)
    end
  end
end

private

  def pega_markers_de_todos_locais(icon)
    pega_markers_dos_locais(icon,Local.find(:all))
  end

  def pega_markers_dos_locais(icon,locais)
    markers = []
    locais.each do |local|
      latitude = local.latitude
      longitude = local.longitude
      lista_projetos = pega_nome_projetos_em(local)
      markers << GMarker.new([latitude,longitude], :icon => icon , :title => local.endereco, :info_window => lista_projetos)
    end
    markers
  end
  
  def pega_nome_projetos_em(local)
    projetos = Projeto.find_all_by_local_id(local)
    projetos.inject("") do |resultado, projeto|
      resultado += cria_linha_projeto(projeto)
    end
  end

