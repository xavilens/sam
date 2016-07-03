class SiteController < ApplicationController

  def index
    @hola = "Hola, mundo!"

    User.initialize_admin_id
  end
end
