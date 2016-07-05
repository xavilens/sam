class SiteController < ApplicationController

  def index
    @hola = t 'hello'

    User.initialize_attributes
  end
end
