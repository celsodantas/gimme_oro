require 'test_helper'

class CSVImporterRBCTest < ActiveSupport::TestCase
  def read_file(filename)
    File.read("#{Rails.root}/test/support/#{filename}")
  end

  setup do
    @user = users(:celso)
  end

  test "should import csv files" do
    file_string = read_file("regular_rbc_csv.csv")

    assert_difference "Entry.count", 8 do
      assert CSVImporterRBC.new.import(@user, file_string)
    end
  end

  test "should import positive values" do
    file_string = read_file("regular_rbc_csv.csv")

    assert CSVImporterRBC.new.import(@user, file_string)

    Entry.all.each do |entry|
      assert entry.amount > 0, "Entry #{entry.description} has a negative value: #{entry.amount}"
    end
  end

  test "should not import the same entry twice" do
    csv_string = <<-CSV
"Account Type","Account Number","Transaction Date","Cheque Number","Description 1","Description 2","CAD$","USD$"
MasterCard,9999900000476666,9/15/2014,,"SHOPPERS DRUG MART OTTAWA ON",,-8.01,,
MasterCard,9999900000476666,9/15/2014,,"SHOPPERS DRUG MART OTTAWA ON",,-8.01,,
    CSV

    assert_difference "Entry.count", 1 do
      assert CSVImporterRBC.new.import(@user, csv_string)
    end
  end
end
