class CreateCommands < ActiveRecord::Migration[5.0]
  def change
    create_table :commands do |t|
      t.string :command_name
      t.references :post
      t.timestamps
    end
  end
end
