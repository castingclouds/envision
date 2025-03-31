class CreateTeams < ActiveRecord::Migration[8.0]
  def change
    create_table :teams do |t|
      t.string :name
      t.text :description
      t.boolean :active

      t.timestamps
    end
  end
end
