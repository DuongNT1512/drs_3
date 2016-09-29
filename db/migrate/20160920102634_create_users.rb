class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :skill
      t.integer :role, default: 2
      t.references :position, foreign_key: true
      t.references :division, foreign_key: true
      t.references :language, foreign_key: true

      t.timestamps
    end
  end
end
