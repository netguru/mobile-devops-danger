require 'net/http'
require 'uri'
require 'json'

module Danger
  module UrlUpload
    attr_accessor :request_url
    attr_accessor :bearer_token

    def upload(json)
      resp = request(json)
      resp.code.to_s.match? /20\d/
    end

    def request(json)
      uri = URI(request_url)
      res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        req = Net::HTTP::Post.new(uri, headers)
        req.body = json.to_json
        http.request(req)
      end
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
