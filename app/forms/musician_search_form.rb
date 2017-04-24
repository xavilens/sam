class MusicianSearchForm < UserSearchForm

  attr_accessor :musician_status, :instruments

  # TODO: Acabar
  def initialize fields = {}
    @type = []
    @musician_status = []
    @instruments = []

    fields.each do |field, value|
      if field == 'type'
        value.delete("")
        value.each {|val| type << val}
      elsif field == 'musician_status'
        value.delete("")
        value.each {|val| musician_status << val}
      elsif field == 'instruments'
        value.delete("")
        value.each {|val| instruments << val}
      elsif MusicianSearchForm.attribute_method? field.to_sym
        public_send("#{field}=",value)
      end
    end
  end

  # Indica si se ha rellenado algún campo de la búsqueda
  def empty?
    empty = super
    empty = empty && musician_status.blank?
    empty = empty && instruments.blank?

    return empty
  end

  # Devuelve los eventos encontrados
  def users model = User.musician
    @users ||= find_users model
  end

  private
    # Búsqueda de eventos según parámetros de búsqueda
    # http://railscasts.com/episodes/111-advanced-search-form-revised
    def find_users model
      users = super model
      # TODO: Acabar de obtener

      return users.order(:name)
    end
end
