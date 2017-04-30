class ImageDecorator < Draper::Decorator
  delegate :current_page, :total_pages, :limit_value, :entry_name, :total_count, :offset_value, :last_page?
  delegate_all

  # Devuelve la imágen al tamaño de la vista del usuario
  def show
    image_url(:gallery_lg)
  end

  # Devuelve la imágen al tamaño de la vista del usuario
  def show_user
    image_url(:thumb)
  end
end
