class BandSearchForm < UserSearchForm
  attr_accessor :status, :genre

  def initialize fields = {}
    @type = []
    @genre = []
    @status = []

    fields.each do |field, value|
      if field == 'type'
        value.delete("")
        value.each {|val| type << val}
      elsif field == 'status'
        value.delete("")
        value.each {|val| status << val.to_i}
      elsif field == 'genre'
        value.delete("")
        value.each {|val| genre << val.to_i}
      elsif UserSearchForm.attribute_method? field.to_sym
        public_send("#{field}=",value)
      end
    end
  end

  # Indica si se ha rellenado algún campo de la búsqueda
  def empty?
    empty = super
    empty = empty && status.blank?
    empty = empty && genre.blank?

    return empty
  end

  # Devuelve los eventos encontrados
  def users model = User.bands
    @users ||= find_users model
  end

  private
    # Búsqueda de eventos según parámetros de búsqueda
    # http://railscasts.com/episodes/111-advanced-search-form-revised
    def find_users model
      users = super model
      users = users.genres(genre) unless genre.blank?
      users = users.band_status(status) unless status.blank?

      return users.uniq.order(:name)
    end
end
