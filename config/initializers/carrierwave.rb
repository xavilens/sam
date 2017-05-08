require 'carrierwave/orm/activerecord'

# Evita un ataque DoS con imagenes modificadas para que sean extremadamente grandes
# href: https://github.com/carrierwaveuploader/carrierwave/wiki/Denial-of-service-vulnerability-with-maliciously-crafted-JPEGs--(pixel-flood-attack)
module CarrierWave
  module MiniMagick
    # check for images that are larger than you probably want
    def validate_dimensions
      manipulate! do |img|
        if img.dimensions.any?{|i| i > 9999 }
          raise CarrierWave::ProcessingError, "La imagen es demasiado grande"
        end
        img
      end
    end
  end
end
