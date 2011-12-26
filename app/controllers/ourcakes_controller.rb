class OurcakesController < ApplicationController
  def index
    u = 'joanne'
    d = 'butterflyicing'
    @email = "#{u}@#{d}.co.uk"
  end
end
