class Entry < ActiveRecord::Base
  default_scope order('entries.date ASC')

  TYPES = %w{income expense}

  validates :amount, presence: true
  validates :date, presence: true
  validates :entry_type, inclusion: { in: TYPES }

  has_and_belongs_to_many :budgets

  def initialize(data = {})
    super(data)
    self.entry_type = "expense"
  end

  def self.for_month(date)
    where("date >= ? AND date <= ?", date.at_beginning_of_month, date.at_end_of_month)
  end

  def self.for_budget(budget)
    joins(:budgets).where("budgets_entries.budget_id = #{budget.id}")
  end

  def self.total_for_month(date)
    for_month(date).map(&:amount).reduce(0, :+)
  end
end
