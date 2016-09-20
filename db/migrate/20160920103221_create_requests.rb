class CreateRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :requests do |t|
      t.references :user, foreign_key: true
      t.string :kind
      t.string :reason
      t.datetime :compensation_time
      t.datetime :date_leave_from
      t.datetime :date_leave_to
      t.boolean :approved

      t.timestamps
    end
  end
end
