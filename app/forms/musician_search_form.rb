class MusicianSearchForm < UserSearchForm
  attr_accessor :status, :instrument

  def initialize fields = {}
    @type = []
    @status = []
    @instrument = []

    fields.each do |field, value|
      if field == 'type'
        value.delete("")
        value.each {|val| type << val}
      elsif field == 'status'
        value.delete("")
        value.each {|val| status << val.to_i}
      elsif field == 'instrument'
        value.delete("")
        value.each {|val| instrument << val.to_i}
      elsif MusicianSearchForm.attribute_method? field.to_sym
        public_send("#{field}=",value)
      end
    end
  end

  # Indica si se ha rellenado algún campo de la búsqueda
  def empty?
    empty = super
    empty = empty && status.blank?
    empty = empty && instrument.blank?

    return empty
  end

  # Devuelve los eventos encontrados
  def users model = User.musicians
    @users ||= find_users model
  end

  private
    # Búsqueda de eventos según parámetros de búsqueda
    # http://railscasts.com/episodes/111-advanced-search-form-revised
    def find_users model
      users = super model
      users = users.instruments(instrument) unless instrument.blank?
      users = users.musician_status(status) unless status.blank?

      return users.uniq.order(:name)
    end
end
