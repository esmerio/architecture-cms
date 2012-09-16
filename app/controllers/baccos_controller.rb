class BaccosController < ApplicationController

  before_filter :autoriza, :except => [:show]

  def edit
    @bacco = Bacco.find(:first)
    @foto = Foto.new
    @foto.grupo_de_fotos = @bacco
  end

  def show
    @bacco = Bacco.find(:first)
  end
  
  def update
    @bacco = Bacco.find(:first)

    respond_to do |format|
      if @bacco.update_attributes(params[:bacco])
        flash[:notice] = 'Equipe foi atualizada com sucesso.'
        format.html { redirect_to('/equipe') }
      else
        format.html { render :action => "edit" }
      end
    end
  end
end

