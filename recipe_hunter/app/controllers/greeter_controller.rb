class GreeterController < ApplicationController

  @@TimesDisplayed = 0

  attr_accessor :random_names
  def initialize
    @random_names = ["John", "Alex", "Joe"]
  end
  def hello
    @name = @random_names.sample
    @time = Time.now
    #@times_displayed ||= 0
    #@times_displayed += 1
    #puts @times_displayed
    @@TimesDisplayed += 1
    @times_displayed = @@TimesDisplayed
  end
  def goodbye
    @name = @random_names.sample
    @time = Time.now
    @times_displayed ||= 0
    @times_displayed += 1
    @@TimesDisplayed += 1
  end
end
