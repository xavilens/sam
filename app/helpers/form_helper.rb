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

  # Indica si se encuentra en el formulario de editar
  def is_edit_form?
    params[:action] == 'edit'
  end

  # Indica si se encuentra en el formulario de crear
  def is_new_form?
    params[:action] == 'new'
  end

end
