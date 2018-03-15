class CreateSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions do |t|
      t.belongs_to :project, foreign_key: true
      t.belongs_to :investor, foreign_key: true

      t.timestamps
    end
  end
end
