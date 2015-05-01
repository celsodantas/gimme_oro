class CsvImportController < ApplicationController
  def index
  end

  def upload
    csv_file = params[:csv_file]

    if csv_file
      CSVImporterRBC.new.import(current_user, csv_file.read)
      flash[:notice] = "CSV Imported successfully"
    else
      flash[:notice] = "No CSV sent."
    end

    render :index
  end
end
