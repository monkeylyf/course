require 'httparty'
require 'pp'


class Recipe
  include HTTParty

  @key_value = ENV['FOOD2FORK_KEY']
  hostport = ENV['FOOD2FORK_SERVER_AND_PORT'] || 'www.food2fork.com'
  base_uri "http://#{hostport}/api"
  format :json

  def self.for term
    get("/search", query: {key: @key_value, q: term})
  end
end

pp Recipe.for 'chocolate'
