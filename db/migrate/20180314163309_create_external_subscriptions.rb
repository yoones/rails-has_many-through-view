class CreateExternalSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :external_subscriptions do |t|
      t.belongs_to :project, foreign_key: true
      t.belongs_to :investor, foreign_key: true

      t.timestamps
    end
  end
end
