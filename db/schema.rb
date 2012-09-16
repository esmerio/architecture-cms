# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 9) do

  create_table "categorias", :force => true do |t|
    t.string   "nome"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "estagios", :force => true do |t|
    t.string   "nome"
    t.integer  "ordem"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "estagios_projetos", :id => false, :force => true do |t|
    t.integer "estagio_id"
    t.integer "projeto_id"
  end

  create_table "fotos", :force => true do |t|
    t.string   "filename"
    t.string   "content_type"
    t.integer  "size"
    t.integer  "width"
    t.integer  "height"
    t.integer  "parent_id"
    t.string   "thumbnail"
    t.integer  "grupo_de_fotos_id"
    t.string   "grupo_de_fotos_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ordem",               :default => 0
  end

  create_table "locals", :force => true do |t|
    t.string   "endereco"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "offices", :force => true do |t|
    t.integer  "projeto_mes_id"
    t.string   "descricao"
    t.integer  "destaque_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projetos", :force => true do |t|
    t.string   "nome"
    t.string   "descricao"
    t.date     "data"
    t.integer  "categoria_id"
    t.integer  "local_id"
    t.integer  "destaque_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
  end

end
