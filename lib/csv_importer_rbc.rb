require 'csv'

class CSVImporterRBC

  def import(user, content)
    CSV.parse(content).each.with_index do |row, index|
      next if index == 0

      entry = Entry.new(user: user)
      entry.description = row[4]
      entry.entry_type = row[6].to_f > 0 ? "income" : "expense"
      entry.amount = row[6].to_f
      entry.date = Date.strptime(row[2], "%m/%d/%Y")

      entry.save! if entry.unique?
    end
  end

end
