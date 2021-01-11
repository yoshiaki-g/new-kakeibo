class BalanceConfirmController < ApplicationController
  def top
  end

  def show
    @year_month = params[:year_month] + "-01"
    @incomes = Income.order(create_at: :asc)
    @fixedcosts = Fixedcost.order(create_at: :asc)
    @variablecosts = Variablecost.order(create_at: :asc)

		@income =Income.where(year_month: @year_month)
		@income_total = ca_income_total(@income)
 
		@fixedcost = Fixedcost.where(year_month: @year_month)
		@fixedcost_total = ca_fixedcost_total(@fixedcost)
 
		@variablecost = Variablecost.where(year_month: @year_month)
		@variablecost_total = ca_variablecost_total(@variablecost)

    @balance_difference = @income_total - (@fixedcost_total + @variablecost_total)
    
    @data = {'収入合計' => @income_total, '固定費合計' => @fixedcost_total, '変動費合計' => @variablecost_total}
 
	end
 
	def show_year
		year = params[:year]
		@year = year
		months = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12" ]
		year_months = months.map do |month|
			year+"-"+month+"-01"
		end
 
		puts year_months
 
		i=0
    total = [0,0,0,0,0,0,0,0,0,0,0,0]
		year_months.each do |year_month|
			income = Income.where(year_month: year_month)
			if income.present?
        total[i] = ca_income_total(income)
			end
			i += 1
    end
    @income_totals = total
    @annual_incomes = @income_totals.sum
 
		i=0
    total = [0,0,0,0,0,0,0,0,0,0,0,0]
		year_months.each do |year_month|
			fixedcost = Fixedcost.where(year_month: year_month)
			if fixedcost.present?
        total[i] = ca_fixedcost_total(fixedcost)
			end
			i += 1
    end
    total[i] = total[i].to_i + 0
    @fixedcost_totals = total
    @annual_fixedcosts = @fixedcost_totals.sum
 
		i=0
    total = [0,0,0,0,0,0,0,0,0,0,0,0]
		year_months.each do |year_month|
			variablecost = Variablecost.where(year_month: year_month)
      if variablecost.present?
        total[i] = ca_variablecost_total(variablecost)
			end
			i += 1
    end
    total[i] = total[i].to_i + 0
    @variablecost_totals = total
    @annual_variablecosts = @variablecost_totals.sum
 
    @balance_differences = [0,0,0,0,0,0,0,0,0,0,0,0]
		0.upto(11) do |i|
			if @income_totals.present?
				@balance_differences[i] = @income_totals[i] - (@fixedcost_totals[i] + @variablecost_totals[i])
      end
    end
    @annual_balance_differences = @balance_differences.sum
    @data = {'年間収入合計' => @annual_incomes, '年間固定費合計' => @annual_fixedcosts, '年間変動費合計' => @annual_variablecosts}
 
	end
 
  private
	def ca_income_total(income)
		income_total = 0 
		income.each do |income|
			income_total += income.value
		end
		income_total
	end
 
	def ca_fixedcost_total(fixedcost)
		fixedcost_total = 0 
		fixedcost.each do |fixedcost|
			fixedcost_total += fixedcost.value
		end
		fixedcost_total
	end
 
	def ca_variablecost_total(variablecost)
		variablecost_total = 0 
		variablecost.each do |variablecost|
			variablecost_total += variablecost.value
		end
		variablecost_total
	end
end