class CreateLocals < ActiveRecord::Migration
  def self.up
    create_table :locals do |t|
      t.string :endereco
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end

  def self.down
    drop_table :locals
  end
end
