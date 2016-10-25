module SearchFormHelper
  # Rellena el campo 'Search' con el parámetro 'param'
  def fill_search_input param
    fill_input(:search, param)
  end

  # Indica si el recurso ':search' está vacío
  def search_blank?
    params[:search].blank?
  end

  # Indica si el parámetro 'param' del recurso :search es nil
  def search_param_blank? param
    params[:search][param].blank?
  end

  # Devuelve el parámetro 'param' del recurso :search
  def search_param param
    params[:search][param]
  end

end
