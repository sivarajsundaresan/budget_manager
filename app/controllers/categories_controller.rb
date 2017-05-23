class CategoriesController < ApplicationController

	def form	
	end

	def create
		if params[:category] == 'ExpenseCategory'
			current_user.expense_categories.create(name: params[:name])
		elsif params[:category] == 'IncomeCategory'
			current_user.income_categories.create(name: params[:name])
		end
		redirect_to budgets_path, notice: 'Category created Successfully'
	end

end
