class SiteController < ApplicationController

  def index
    @hola = "Hola, mundo!"

    User.initialize_attributes
  end
end
