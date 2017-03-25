class BandDecorator < Draper::Decorator
  delegate_all

  # Wrapper para colecciones
  def self.wrap(collection)
    collection.map do |obj|
        new obj
    end
  end
end
