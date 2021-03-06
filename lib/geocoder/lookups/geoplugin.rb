# -*- encoding: utf-8 -*-
require 'geocoder/lookups/base'
require 'geocoder/results/geoplugin'

module Geocoder::Lookup
  class Geoplugin < Base

    def name
      "geoPlugin"
    end

    def query_url(query)
      "http://www.geoplugin.net/json.gp?" + url_query_string(query)
    end

    private # ---------------------------------------------------------------

    def results(query, reverse = false)
      return [] unless doc = fetch_data(query)
      case doc['geoplugin_status']
      when 200
        return [doc]
      else
        raise_error(Geocoder::Error, "server error.") ||
          warn("#{self.name} Geocoding API error: server error.")
      end
      return []
    end

    def query_url_params(query)
      {
        ip: query.sanitized_text
      }.merge(super)
    end

  end
end