module SearchFormHelper

  def fill_search_input param
    fill_input(:search, param) 
  end

  def search_blank?
    params[:search].blank?
  end

  def search_param_blank? param
    params[:search][param].blank?
  end

  def search_param param
    params[:search][param]
  end

end
