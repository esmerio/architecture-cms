class FotosController < ApplicationController
  
  before_filter :autoriza
  
  # GET /fotos
  # GET /fotos.xml
  def index
    @fotos = Foto.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @fotos }
    end
  end

  # GET /fotos/1
  # GET /fotos/1.xml
  def show
    @foto = Foto.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @foto }
    end
  end

  # GET /fotos/new
  # GET /fotos/new.xml
  def new
    @foto = Foto.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @foto }
    end
  end

  # GET /fotos/1/edit
  def edit
    @foto = Foto.find(params[:id])
  end

  # POST /fotos
  # POST /fotos.xml
  def create
    @foto = Foto.new(params[:foto])

    respond_to do |format|
      if @foto.save
        @fotos = Foto.find(:all)
        flash[:notice] = 'Foto was successfully created.'
        format.html { redirect_to(@foto) }
        format.js do
          responds_to_parent do
            render :update do |page|
              page.insert_html :bottom, 'fotos', image_tag(@foto.public_filename(:thumb), :id => 'foto_'+@foto.id.to_s, :class => 'normal', :onClick => "javascript:change_foto_principal('#{params[:campo_destaque]}', #{@foto.id}, '#{@foto.public_filename}');")
              page.insert_html :bottom, 'fotos', link_to_remote(image_tag('remove.png', :id => 'remove_' + @foto.id.to_s, :class=>'imagem_remover'), {:url => foto_path(@foto), :method => :delete, :confirm => "Tem certeza?"})
              page << 'document.getElementById("foto_form").reset(); make_invisible("cortina_fotos"); make_invisible("form_fotos");'
              page << 'var div = document.getElementById("fotos"); var width=parseInt(div.style.width)+105;div.style.width=width+"px";'
              page << 'var lista = document.getElementById("lista_de_fotos"); if(lista.scrollUpdate) lista.scrollUpdate();'
            end
          end
        end
      else
        format.html { render :action => "new" }
        format.js do
          responds_to_parent do
            render :update do |page|
            end
          end
        end
      end
    end
  end

  # DELETE /fotos/1
  # DELETE /fotos/1.xml
  def destroy
    @foto = Foto.find(params[:id])
    @foto.destroy
    @fotos = Foto.find(:all)

    respond_to do |format|
      format.html { redirect_to(fotos_url) }
      format.xml  { head :ok }
      format.js {
        render :update do |page|
          page.remove 'foto_'+@foto.id.to_s, 'remove_'+@foto.id.to_s
          page << 'var div = document.getElementById("fotos");var width=parseInt(div.style.width)-105;div.style.width=width+"px";'
              page << 'var lista = document.getElementById("lista_de_fotos");if(lista.scrollUpdate) lista.scrollUpdate();'
        end
      }
    end
  end
end
