class AddCsvExportUrlToGoogleSheetUrls < ActiveRecord::Migration[8.0]
  def change
    add_column :google_sheet_urls, :csv_export_url, :string
    add_column :google_sheet_urls, :gid, :string
    add_column :google_sheet_urls, :start_at_row, :integer
    
  end
end