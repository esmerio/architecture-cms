module WelcomeHelper
  def formata_estagios(estagios)
    estagios.collect(&:nome).join(", ")
  end

  def toggle_mudanca_projetos
    toggle_displays(['change_image','image_popup'])
  end

end
