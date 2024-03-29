class CreateOffices < ActiveRecord::Migration
  def self.up
    create_table :offices do |t|
      t.references :projeto_mes, :class_name => 'Projeto'
      t.string :descricao
      t.references :destaque, :class_name => 'Foto'

      t.timestamps
    end
  end

  def self.down
    drop_table :offices
  end
end
