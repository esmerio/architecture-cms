module ProjetoHelper
  def tem_estagio(projeto, estagio)
    if projeto.estagios.member? estagio
      return "<span class='quadradinho "+
            "estagio" + estagio.id.to_s + "' " +
            #"estagio" + estagio.ordem.to_s + "' " +
            "title='"+ estagio.nome + "' " +
            ">&nbsp;</span>"
    else
      return "<span class='quadradinho "+
            "estagio_none' " +
            ">&nbsp;</span>"
    end
  end

  def carrega_mapa_estagios(projetos)
    linhas = projetos.collect do |projeto|
      estagios = lista_js(projeto.estagios, 'estagio')
      "adiciona_projeto('projeto#{projeto.id}', #{estagios})"
    end
    linhas.join(";") + ";"
  end

  def filtra_projetos(estagio)
    projetos = lista_js(estagio.projetos, 'projeto')
    "javascript:toggle_display('estagio#{estagio.id}');filtra_projetos(#{projetos});"
  end

  def erros_de_projetos(projeto)
    unless projeto.errors.empty?
     "<p id='msgerro'>Existem erros que impedem esse projeto de ser salvo. <br/>Verifique a presença de T&iacute;tulo,Data e Categoria</p>"
    end
  end

  def lista_js(lista_rb, nome)
    "[" + lista_rb.collect { |elem| "'#{nome}#{elem.id}'" }.join(",") + "]"
  end

  def mostra_local(projeto)
    projeto.local.nil? ? '' : projeto.local.endereco
  end

  def toggle_texto_projeto
    toggle_displays(['texto_projeto','link_texto_projeto','link_texto_projeto_inv'])
  end

end
