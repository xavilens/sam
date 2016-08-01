module AppHelper

  def traducir_type type
    if type == 'Musician'
      'Músico'
    elsif type == 'Musicians'
      'Músicos'
    elsif type == 'Band'
      'Grupo'
    elsif type == 'Bands'
      'Grupos'
    elsif type == 'User'
      'Usuario'
    elsif type == 'Users'
      'Usuarios'
    else
      type
    end
  end

  def page_title page = nil
    title = 'S.A.M. - Sociedad Anónima Músical'

    title = "#{traducir_type(page)} | "+title unless page.blank?

    content_for :title, title
  end

  def active_page controller
    'active' if params[:controller] == controller
  end

end
