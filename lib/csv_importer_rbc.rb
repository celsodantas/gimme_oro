require 'csv'

class CSVImporterRBC

  def import(user, content)
    CSV.parse(content).each.with_index do |row, index|
      begin
        next if index == 0

        entry = Entry.new(user: user)
        entry.description = row[4]
        entry.entry_type = row[6].to_f > 0 ? "income" : "expense"
        entry.amount = row[6].to_f.abs
        entry.date = Date.strptime(row[2], "%m/%d/%Y")

        if entry.unique?
          entry.save!
        else
          Rails.logger.info "[CSVImport] Skipping #{index} as duplicate"
        end
      rescue Exception => e
        Rails.logger.info "row #{index} failed to import. #{e.inspect}:"
        Rails.logger.info row
      end
    end

    true
  end

end
