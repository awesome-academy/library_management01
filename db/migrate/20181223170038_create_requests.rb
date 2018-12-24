class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.references :user, foreign_key: true
      t.datetime :from_day
      t.datetime :to_day
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end