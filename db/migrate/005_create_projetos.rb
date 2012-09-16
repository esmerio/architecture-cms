class CreateProjetos < ActiveRecord::Migration
  def self.up
    create_table :projetos do |t|
      t.string :nome
      t.string :descricao
      t.date :data
      t.references :categoria, :class_name => 'Categoria'
      t.references :local, :class_name => 'Local'
      t.references :destaque, :class_name => 'Foto'

      t.timestamps
    end
  end

  def self.down
    drop_table :projetos
  end
end
