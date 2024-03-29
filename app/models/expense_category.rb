class ExpenseCategory < ApplicationRecord
	has_many :budgets, as: :spend
	belongs_to :user

	scope :get_name, -> (id) { find_by(id: id).name }

	scope :get_record, -> (user_id) { where(user_id: [user_id, nil]) }

	validates :name, :presence => true, :uniqueness => {:scope => :user_id, :case_sensitive => false }

end
