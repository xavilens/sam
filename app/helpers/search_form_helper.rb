module SearchFormHelper

  def fill_input resource, param
    params[resource][param] unless params[resource].blank? || params[resource][param].blank?
  end

end
