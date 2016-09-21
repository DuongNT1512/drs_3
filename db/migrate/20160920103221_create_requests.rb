class CreateRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :requests do |t|
      t.references :user, foreign_key: true
      t.integer :kind
      t.string :reason
      t.datetime :compensation_time_from
      t.datetime :compensation_time_to
      t.datetime :date_leave_from
      t.datetime :date_leave_to
      t.integer :approved, default: 0

      t.timestamps
    end
  end
end
