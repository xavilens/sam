module SiteHelper

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

  def page_title type = nil
    title = 'S.A.M. - Sociedad Anónima Músical'

    title = "#{traducir_type(type)} | "+title unless type.blank?

    content_for :title, title
  end

  def active_page controller
    active = 'active' if params[:controller] == controller
    return active
  end
end
