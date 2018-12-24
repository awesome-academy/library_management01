class CreateAuthors < ActiveRecord::Migration[5.2]
  def change
    create_table :authors do |t|
      t.string :name
      t.text :profile
      t.string :avatar

      t.timestamps
    end
  end
end
