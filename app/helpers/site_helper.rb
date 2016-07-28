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
    else
      type
    end
  end

  def page_title type = nil
    title = 'S.A.M. - Sociedad Anónima Músical'

    title = "#{traducir_type(type)} | "+title unless type.blank?

    content_for :title, title
  end
end
