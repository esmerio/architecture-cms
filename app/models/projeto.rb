class Projeto < ActiveRecord::Base
  validates_presence_of :nome, :data , :categoria
  belongs_to :categoria
  belongs_to :local
  has_and_belongs_to_many :estagios

  has_many :fotos, :as => 'grupo_de_fotos'
  belongs_to :destaque, :class_name => 'Foto'
  
  def categoria?(id)
    if categoria.nil?
      false
    else
      categoria.id == id
    end
  end
  
end
