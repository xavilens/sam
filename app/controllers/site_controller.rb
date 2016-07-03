class SiteController < ApplicationController
  
  def index
    @hola = "Hola, mundo!"

    if User.admin_id.nil?
      User.initialize_admin_id
    end

  end
end
