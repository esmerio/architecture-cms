class RelacionaEstagiosProjetos < ActiveRecord::Migration
  def self.up
    create_table :estagios_projetos, :id => false do |t|
      t.integer :estagio_id
      t.integer :projeto_id
    end
  end

  def self.down
    drop_table :estagios_projetos
  end
end

