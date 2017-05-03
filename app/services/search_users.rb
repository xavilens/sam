# Servicio encargado de buscar usuarios
# TODO: BORRAR
class SearchUsers
  def initialize (params)
    @params = params
  end

  def users
    users = unless params.blank?
      name = params.delete(:name)
      location = params.delete(:location)

      User.where(params).name_like(name)#.in_location(location)
    else
      User.all
    end

    return users.decorate
  end

  private

  attr_accessor :params
end
