class CreateCats < ActiveRecord::Migration
  def up
    create_table :cats do |t|
      t.string :name
      t.text :description
      t.integer :age
      t.string :color
      t.timestamp :created_at
      t.timestamp :updated_at
    end
  end

  def down
    drop_table :cats
  end
end