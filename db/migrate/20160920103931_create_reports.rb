class CreateReports < ActiveRecord::Migration[5.0]
  def change
    create_table :reports do |t|
      t.string :working_day
      t.references :user, foreign_key: true
      t.references :languages, foreign_key: true
      t.references :progress, foreign_key: true

      t.timestamps
    end
  end
end
