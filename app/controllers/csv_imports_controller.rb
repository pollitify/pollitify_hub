class CsvImportsController < ApplicationController
  require 'csv'

  def new
  end

  def preview
    # Store file temporarily (ActiveStorage or tmp directory)
    @file = params[:file]
    if @file.nil?
      redirect_to new_csv_import_path, alert: "Please upload a CSV file"
      return
    end

    # Save to tmp for preview use
    tmp_path = Rails.root.join("tmp", "#{SecureRandom.uuid}.csv")
    File.open(tmp_path, "wb") { |f| f.write(@file.read) }
    session[:csv_file_path] = tmp_path.to_s

    # Read first few rows for preview
    @rows = CSV.read(tmp_path, encoding: "UTF-8", headers: false)
    @rows = @rows.first(10) # Limit preview to 10 rows
  end

  def process_import
    header_row_index = params[:header_row_index].to_i
    file_path = session[:csv_file_path]

    if file_path.nil? || !File.exist?(file_path)
      redirect_to new_csv_import_path, alert: "CSV file not found. Please upload again."
      return
    end

    csv = CSV.read(file_path, encoding: "UTF-8", headers: false)
    headers = csv[header_row_index]
    data = csv[(header_row_index + 1)..] # everything after header row

    # Now you have headers and rows
    data.each do |row|
      row_hash = headers.zip(row).to_h
      # Process row_hash as needed
    end

    redirect_to some_path, notice: "CSV import complete"
  end
end
