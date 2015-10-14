require 'httparty'
require 'pp'


class Coursera
  include HTTParty

  key_value = ENV['FOOD2FORK_KEY']
  hostport = ENV['FOOD2FORK_SERVER_AND_PORT'] || 'www.food2fork.com'
  base_uri "http://#{hostport}/api"
  default_params key: key_value
  format :json

  def self.for(term)
    get("/search", query: { q: term })#["recipes"]
  end
end

#  include HTTParty
#
#  base_uri 'https://api.coursera.org/api/catalog.v1/courses/'
#  default_params fields: "smallIcon,shortDescription", q: "search"
#  format :json
#
#  def self.for term
#    get("", query: { query: term})["elements"]
#  end
#end

#puts Coursera.for('chocolate').methods
