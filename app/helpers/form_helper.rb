module FormHelper

  def fill_input resource, param
    params[resource][param] unless resource_blank?(resource) || param_blank?(resource, param)
  end

  def resource_blank? resource
    params[resource].blank?
  end

  def param_blank? resource, param
    params[resource][param].blank?
  end

end
