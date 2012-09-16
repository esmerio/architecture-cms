class AdicionaOrdemFotos < ActiveRecord::Migration
  def self.up
    add_column :fotos, :ordem, :integer, :default => 0
    
    projetos = Projeto.find(:all)
    projetos.each do |p|
      p "Processing #{p.nome}"
      counter = 1
      p.fotos.each do |f|
        f.ordem = counter
        f.save
        counter += 1
        puts "  -Given #{f.ordem} position to Image #{f.filename}"
      end
      p.save
    end
    
  end

  def self.down
    remove_column :fotos, :ordem
  end
end
