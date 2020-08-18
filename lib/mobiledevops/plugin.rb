require "google_drive"
require "mobiledevops/url_upload"

module Danger
  class DangerMobiledevops < Plugin
    include ::Danger::UrlUpload

    attr_accessor :account_key_file_name

    def post_to_dash(project_name, coverage)
      
      unless account_key_file_name.nil?
        session = GoogleDrive::Session.from_service_account_key("./#{account_key_file_name}")
        ws = session.spreadsheet_by_key("1asrqQsVkFVHHzfbkRjb7p3r6mTdDYdyRD9dlqF9qOcI").worksheets[0]
        row = ws.num_rows+1
        ws[row,1] = "#{project_name}"
        ws[row,2] = "#{coverage}"
        ws.save
      end
      
    end
  end
end
