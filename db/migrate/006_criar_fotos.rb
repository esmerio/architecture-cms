class CriarFotos < ActiveRecord::Migration
  def self.up
    create_table :fotos do |t|
      t.string :filename
      t.string :content_type
      t.integer :size
      t.integer :width
      t.integer :height
      t.integer :parent_id
      t.string :thumbnail
      t.references :grupo_de_fotos, :polymorphic => true

      t.timestamps
    end
  end

  def self.down
    drop_table :fotos
  end
end

