module Charger

  class Client
    attr_accessor :api_key, :subdomain

    def initialize api_key, subdomain
      @api_key = api_key
      @subdomain = subdomain
    end

    def get resource, headers={}
      JSON.parse(RestClient.get(resource_url(resource), rest_headers(headers)))
    end

    def post resource, payload, headers={}
      JSON.parse(RestClient.post(resource_url(resource), payload, rest_headers(headers)))
    end

    def put resource, payload, headers={}
      JSON.parse(RestClient.put(resource_url(resource), payload, rest_headers(headers)))
    end

    def delete resource, headers={}
      JSON.parse(RestClient.delete(resource_url(resource), rest_headers(headers)))
    end

    private

    def rest_headers options={}
      { :content_type => :json, :accept => :json }.merge(options)
    end

    def resource_url resource
      req = resource.gsub(/^\//,'')
      "https://#{@api_key}:x@#{@subdomain}.chargify.com/#{req}"
    end
  end

end
