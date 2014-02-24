class Budget < ActiveRecord::Base
  
  has_and_belongs_to_many :entries

  def for_month(date)
    entries.for_month(date)
  end

  def sum_for_month(date)
    @sum_for_month ||= for_month(date)
                        .for_budget(self)
                        .map {|entry| entry.amount }
                        .reduce(0, :+).to_f
  end

  def excedded_for_month(date)
    sum_for_month(date) > amount
  end

  def month_percentage(date)
    amount > 0 ? (sum_for_month(date) / amount) * 100 : 0.0
  end
end
