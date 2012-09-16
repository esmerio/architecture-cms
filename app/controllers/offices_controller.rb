class OfficesController < ApplicationController

  before_filter :autoriza, :except => [:show]

  def edit
    @office = Office.find(:first)
    @foto = Foto.new
    @foto.grupo_de_fotos = @office
  end

  def show
    @office = Office.find(:first)
  end
  
  def update
    @office = Office.find(:first)

    respond_to do |format|
      if @office.update_attributes(params[:office])
        flash[:notice] = 'Equipe foi atualizada com sucesso.'
        format.html { redirect_to('/equipe') }
      else
        format.html { render :action => "edit" }
      end
    end
  end
end

