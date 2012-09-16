class WelcomeController < ApplicationController
  def index
    @bacco = Bacco.find(:first)
    @projeto_mes = @bacco.projeto_mes
    @foto = @projeto_mes.destaque
    @projetos = Projeto.find(:all)
    respond_to do |format|
      format.html #index.html.erb
    end
  end

  def muda_projeto_mes
    @bacco = Bacco.find(:first)
    @bacco.update_attributes(params[:bacco])
    respond_to do |format|
      format.html { redirect_to root_path}
    end
  end

  def auto_complete_for_projeto_nome
    auto_complete_responder_for_projetos params[:projeto][:nome]
  end

  private
  def auto_complete_responder_for_projetos(valor)
    @projetos = Projeto.find(:all,
      :conditions => [ 'LOWER(nome) LIKE ?',
      '%' + valor.downcase + '%' ],
      :order => 'id DESC',
      :limit => 8)
    render :partial => 'auto_complete'
  end

end
