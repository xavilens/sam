module LandingHelper
  # Devuelve al azar una imagen de fondo
  # ref: http://stackoverflow.com/questions/14404801/random-background-picture-css-rails
  def randomized_background_image
    images = ["back-7.jpg", "back-1.jpg", "back-2.jpg", "back-3.jpg", "back-4.jpg", "back-5.jpg", "back-6.jpg"]
    image = images[rand(images.size)]

    return image_url("landing/#{image}")
  end
end
