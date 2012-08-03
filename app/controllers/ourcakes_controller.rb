class OurcakesController < ApplicationController
#TODO remove email address from view and add link to contact us
  def index
    u = 'joanne'
    d = 'butterflyicing'
    @email = "#{u}@#{d}.co.uk"
  end
end
