require 'httparty'
require 'pp'


class RecipesController < ApplicationController
  def index
    search_term = params[:search] || 'chocolate'
    Rails.logger.debug("My object: #{@RecipeFetcher.inspect}")
    http_resp = RecipeFetcher.for(@search_term)
    Rails.logger.debug("My object: #{@http_resp.inspect}")
    hash_response = JSON.parse(http_resp)
    @recipes = hash_response['recipes']
  end
end



class RecipeFetcher
  include HTTParty

  key_value = ENV['FOOD2FORK_KEY']
  hostport = ENV['FOOD2FORK_SERVER_AND_PORT'] || 'www.food2fork.com'
  base_uri "http://#{hostport}/api"
  default_params key: key_value
  format :json

  def self.for term
    get("/search", query: {q: term})
  end
end


pp RecipeFetcher.for('chocolate')

