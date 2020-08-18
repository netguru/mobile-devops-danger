require "typhoeus"

module Danger
  module UrlUpload
    attr_accessor :request_url
    attr_accessor :bearer_token

    def upload(json)
      req = request(json)
      resp = req.run
      resp.code.to_s.match? /20\d/
    end

    def request(json)
      Typhoeus::Request.new(
          request_url,
        method: request_method,
        body: json,
        headers: headers
      )
    end

    def request_method=(method)
      raise ArgumentError unless [:post, :put].include? method
      @request_method = method
    end

    def request_method
      @request_method || :post
    end

    def headers
      { 'Authorization' => "bearer #{bearer_token}" } if bearer_token
    end
  end
end
