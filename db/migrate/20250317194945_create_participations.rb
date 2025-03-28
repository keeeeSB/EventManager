class CreateParticipations < ActiveRecord::Migration[7.2]
  def change
    create_table :participations do |t|
      t.string :status, null: false, default: "pending"
      t.references :user, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
