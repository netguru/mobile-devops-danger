require "google_drive"
require "mobiledevops/url_upload"

module Danger
  class DangerMobiledevops < Plugin
    include ::Danger::UrlUpload

  end
end
