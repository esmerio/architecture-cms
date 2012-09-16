class Bacco < ActiveRecord::Base
  belongs_to :projeto_mes, :class_name => 'Projeto'

  has_many :fotos, :as => 'grupo_de_fotos'
  belongs_to :destaque, :class_name => 'Foto'

end
