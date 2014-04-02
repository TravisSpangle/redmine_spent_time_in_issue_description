class SpentTimeController < ApplicationController
  unloadable

  require 'pry'
  require 'pry-debugger'


  def show
    binding.pry

  end
end
