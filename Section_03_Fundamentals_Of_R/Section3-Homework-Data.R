#Data
revenue <- c(14574.49, 7606.46, 8611.41, 9175.41, 8058.65, 8105.44, 11496.28, 9766.09, 10305.32, 14379.96, 10713.97, 15433.50)
expenses <- c(12051.82, 5695.07, 12319.20, 12089.72, 8658.57, 840.20, 3285.73, 5821.12, 6976.93, 16618.61, 10054.37, 3803.96)

#Solution
profit <- revenue - expenses
profit_rounded <- round(profit/1000,0)
profit_rounded

tax <- round(0.30 * profit,2)
profit_after_tax = profit - tax
profit_after_tax_rounded <- round(profit_after_tax/1000,0)
profit_after_tax_rounded

profit_margin <- round(profit_after_tax/revenue * 100 , 0)
profit_margin

mean_profit_after_tax <- mean(profit_after_tax)
mean_profit_after_tax
mean_profit_after_tax_rounded = round(mean_profit_after_tax/1000,0)
mean_profit_after_tax_rounded

good_months <- profit_after_tax >= mean_profit_after_tax
good_months

bad_months <- profit_after_tax < mean_profit_after_tax
bad_months

best_month <- profit_after_tax == max(profit_after_tax)
best_month

worst_month <- profit_after_tax == min(profit_after_tax)
worst_month
