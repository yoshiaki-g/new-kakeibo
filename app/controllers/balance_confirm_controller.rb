class BalanceConfirmController < ApplicationController
  def top
  end

  def show
    @year_month = params[:year_month] + "-01"
    @incomes = Income.order(create_at: :asc)
    @fixedcosts = Fixedcost.order(create_at: :asc)
    @variablecosts = Variablecost.order(create_at: :asc)

    #収入計算
		@income =Income.where(year_month: @year_month)
		@income_total = ca_income_total(@income)
 
		#固定費計算
		@fixedcost = Fixedcost.where(year_month: @year_month)
		@fixedcost_total = ca_fixedcost_total(@fixedcost)
 
		#変動費計算
		@variablecost = Variablecost.where(year_month: @year_month)
		@variablecost_total = ca_variablecost_total(@variablecost)
 
		#収支差
		@balance_difference = @income_total - (@fixedcost_total + @variablecost_total)
 
	end
 
	def show_year
		year = params[:year]
		@year = year
		months = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12" ]
		year_months = months.map do |month|
			year+"-"+month+"-01"
		end
 
		puts year_months
 
		#年度の収入配列を作成
		i=0
		total = [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil]
		year_months.each do |year_month|
			income = Income.where(year_month: year_month)
			if income.present?
				total[i] = ca_income_total(income)
			end
			i += 1
		end
		@income_totals = total
 
		#年度の固定費配列を作成
		i=0
		total = [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil]
		year_months.each do |year_month|
			fixedcost = Fixedcost.where(year_month: year_month)
			if fixedcost.present?
				total[i] = ca_fixedcost_total(fixedcost)
			end
			i += 1
		end
		@fixedcost_totals = total
 
		#年度の変動費配列を作成
		i=0
		total = [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil]
		year_months.each do |year_month|
			variablecost = Variablecost.where(year_month: year_month)
			if variablecost.present?
				total[i] = ca_variablecost_total(variablecost)
			end
			i += 1
		end
		@variablecost_totals = total
 
		#年度の収支結果を計算
		@balance_differences = [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil]
		0.upto(11) do |i|
      if @income_totals[i].present?
        # binding.pry
				@balance_differences[i] = @income_totals[i] - (@fixedcost_totals[i] + @variablecost_totals[i])
			end
		end
	end
 
	#収入トータル計算
	def ca_income_total(income)
		income_total = 0 #固定費合計
		income.each do |income|
			income_total += income.value
		end
		income_total
	end
 
	#固定費トータル計算
	def ca_fixedcost_total(fixedcost)
		fixedcost_total = 0 #固定費合計
		fixedcost.each do |fixedcost|
			fixedcost_total += fixedcost.value
		end
		fixedcost_total
	end
 
	#変動費トータル計算
	def ca_variablecost_total(variablecost)
		variablecost_total = 0 #変動費合計
		variablecost.each do |variablecost|
			variablecost_total += variablecost.value
		end
		variablecost_total
	end
end