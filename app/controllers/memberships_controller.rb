class MembershipsController < ApplicationController
  before_filter :authenticate_user!

  def add
    redirect_to :back, notice: 'Prueba'
  end
end
