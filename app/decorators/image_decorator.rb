class ImageDecorator < Draper::Decorator
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
