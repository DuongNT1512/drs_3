class CreateReports < ActiveRecord::Migration[5.0]
  def change
    create_table :reports do |t|
      t.integer :working_day
      t.references :user, foreign_key: true
      t.references :language, foreign_key: true
      t.references :progress, foreign_key: true
      t.references :division, foreign_key: true
      t.string :achievement

      t.timestamps
    end
  end
end
