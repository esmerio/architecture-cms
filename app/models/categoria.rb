class Categoria < ActiveRecord::Base
  has_many :projetos
end
