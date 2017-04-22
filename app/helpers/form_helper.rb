module FormHelper
  ######### FORM INPUT
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

  ######### FORM TYPE
  # Indica si se encuentra en el formulario de editar
  def is_edit_form?
    params[:action] == 'edit'
  end

  # Indica si se encuentra en el formulario de crear
  def is_new_form?
    params[:action] == 'new'
  end

  # Devuelve el mensaje a mostrar en el botón submit
  def data_disable_submit_message
    ''

    if is_new_form?
      'Creando...'
    elsif is_edit_form?
      'Actualizando...'
    end
  end

  ######### FORM ERRORS
  # Mensaje por defecto de la sección de errores de un formulario en un modal
  def form_errors_title_modal
    "Algo fue mal... Por favor, revise los siguientes problemas"
  end

  # Mensaje por defecto de la sección de errores de un formulario
  def form_errors_title
    form_errors_title_modal + ":"
  end

  # Devuelve la sección de error por defecto
  def form_errors_section object
    render 'layouts/errors', object: object
  end
end
