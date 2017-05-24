class BudgetsController < ApplicationController
	before_action :set_budget, only: [:edit, :update, :destroy]
	
	def index
		@budgets = set_current_budget.filter_records(params[:spend_type], params[:date_range])
	end

	def new
		@budget = set_current_budget.new
	end

	def create
		@budget = set_current_budget.new(budget_params)
		respond_to do |format|  
			if @budget.save
				format.html { redirect_to budgets_path, notice: 'Budget was Successfully Created' }
			else
				format.html { render :new }
			end
		end
	end


	def edit
	end

	def update
		respond_to do |format|
			if @budget.update(budget_params)
				format.html { redirect_to budgets_path, notice: 'Budget was Successfully Updated' }
			else
				format.html { render :edit }
			end
		end
	end

	def destroy
		@budget.destroy
		respond_to do |format|
			format.html { redirect_to budgets_path, notice: 'Budget was Successfully destroyed' }
		end
	end

	def category_record
		record = Budget.category_record(params[:category], current_user.id)
		render json: { status: 200, info: record }	
	end

	def filter_record
		@budgets = set_current_budget.filter_records(params[:spend_type], params[:date_range])	
	end

	def download_pdf
		@budgets = set_current_budget.filter_records(params[:spend_type], params[:date_range])
		respond_to do |format|
			format.pdf do
				html = render_to_string(:action => :download_pdf, :layout => "pdf.html.erb")
				pdf = WickedPdf.new.pdf_from_string(html) 
				send_data(pdf,:filename => "Download_pdf_record.pdf",:disposition => 'attachment', :type => "application/pdf")
  		end
		end
	end

	def download_csv
		@budgets = set_current_budget.filter_records(params[:spend_type], params[:date_range])
		respond_to do |format|
			format.csv { send_data @budgets.to_csv, filename: "budgets-#{Date.today}.csv" }
		end
	end

	private

	def set_budget
		@budget = current_user.budgets.find(params[:id])
	end

	def set_current_budget
		current_user.budgets
	end

	def budget_params
		params.require(:budget).permit(:amount, :date_time, :description, :spend_id, :spend_type, :user_id)
	end

end
