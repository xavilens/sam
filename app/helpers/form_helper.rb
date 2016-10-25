module FormHelper
  # Rellena el campo del recurso 'resource' con el parámetro 'param'
  def fill_input resource, param
    params[resource][param] unless resource_blank?(resource) || param_blank?(resource, param)
  end

  # Indica si el recurso 'resource' está vacío
  def resource_blank? resource
    params[resource].blank?
  end

  # Indica si el parámetro 'param' está vacío
  def param_blank? resource, param
    params[resource][param].blank?
  end

end
