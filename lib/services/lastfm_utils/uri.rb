require 'json'
require 'net/http'
require 'uri'

module Services
  module LastfmUtils
    class Uri
      attr_reader :signature

      def initialize(signature, api_key: api_key)
        @api_key = api_key
        @signature = signature
      end

      def get
        JSON.parse(Net::HTTP.get(build))
      end

      def build
        URI::HTTP.build(host: host, path: path, scheme: scheme, query: query)
      end

      private
      def api_key
        @api_key ||
          YAML.load_file("#{Rails.root}/config/lastfm.yml")[Rails.env]["lastfm_api_key"]
      end

      def host
        "ws.audioscrobbler.com"
      end

      def path
        "/2.0/"
      end

      def query
        "method=#{signature}&api_key=#{api_key}&format=json"
      end

      def scheme
        "http"
      end
    end
  end
end

