class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :username
      t.string :website
      t.text :profiletext
      t.string :email
      t.string :tel
      t.string :sex

      t.timestamps
    end
  end
end
