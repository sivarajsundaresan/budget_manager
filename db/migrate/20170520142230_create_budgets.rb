class CreateBudgets < ActiveRecord::Migration[5.0]
  def change
    create_table :budgets do |t|
    	t.float :amount
    	t.string :date_time
    	t.string :description
    	t.integer :spend_id, index: true
    	t.string :spend_type, index: true
      t.references :user
      t.timestamps
    end
  end
end
