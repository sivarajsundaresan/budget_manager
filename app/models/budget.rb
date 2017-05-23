class Budget < ApplicationRecord
	belongs_to :spend, polymorphic: true
	belongs_to :user

	scope :spend_type_rec, -> (spend_type) { where(spend_type: spend_type) }

	scope :filter_date_time, -> (start_date, end_date) { where(date_time: start_date..end_date) }

	validates :amount, presence: true
	validates :date_time, presence: true
	validates :description, presence: true
	validates :spend_type, presence: true
	validates :spend_id, presence: true

	SPENDTYPE = { 'Expense' => 'ExpenseCategory',  'Income' => 'IncomeCategory' }


	def self.filter_records(spend_type, date_range)
		start_date, end_date = date_range_filter(date_range)
		record = filter_date_time(start_date, end_date)
		record = record.spend_type_rec(spend_type) if spend_type.present?
		record
	end

	def self.date_range_filter(date_range)
		if date_range.present?
      start_date, end_date = [ Date.strptime(date_range.split("-")[0], "%m/%d/%Y").beginning_of_day.strftime("%Y/%m/%d %H:%M"), Date.strptime(date_range.split("-")[1], " %m/%d/%Y").end_of_day.strftime("%Y/%m/%d %H:%M") ]
    else
      start_date, end_date = [ Date.today.beginning_of_day.strftime("%Y/%m/%d %H:%M"), Date.today.end_of_day.strftime("%Y/%m/%d %H:%M") ]
    end
	end

	def self.category_record(category, user_id)
		if category == "ExpenseCategory"
			ExpenseCategory.get_record(user_id)
		elsif category == "IncomeCategory"
			IncomeCategory.get_record(user_id)
		end	
	end

	def self.spend_type(type)
		if type == 'ExpenseCategory'
			"Expense"
		elsif type == 'IncomeCategory'
			"Income"
		end	
	end

	def self.category_name(id, type)
		if type == "ExpenseCategory"
			ExpenseCategory.get_name(id)
		elsif type == "IncomeCategory"
			IncomeCategory.get_name(id)
		end			
	end

	def self.to_csv
		CSV.generate(headers: true) do |csv|
      csv << [ 'Date', 'Amount', 'Spend_type' , 'Spend', 'Description'  ]

      all.each do |user|
        csv << [ user.date_time, user.amount, spend_type(user.spend_type), category_name(user.spend_id, user.spend_type), user.description ]
      end
    end
	end

end