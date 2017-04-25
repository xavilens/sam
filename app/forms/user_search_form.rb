class UserSearchForm < SearchForm

  attr_accessor :name, :type, :location_type, :city, :province, :region
  attr_reader :users

  def initialize fields = {}
    @type = []

    fields.each do |field, value|
      if field == 'type'
        value.delete("")
        value.each {|val| type << val}
      elsif UserSearchForm.attribute_method? field.to_sym
        public_send("#{field}=",value)
      end
    end
  end

  # Indica si se ha rellenado algún campo de la búsqueda
  def empty?
    empty = name.blank?
    empty = empty && type.blank?
    empty = empty && !(location_type == 'city' && city.present?)
    empty = empty && !(location_type == 'province' && province.present?)
    empty = empty && !(location_type == 'region' && region.present?)

    return empty
  end

  # Devuelve los eventos encontrados
  def users model = User
    @users ||= find_users model
  end

  private
    # Búsqueda de eventos según parámetros de búsqueda
    # http://railscasts.com/episodes/111-advanced-search-form-revised
    def find_users model
      users = model.all

      unless empty?
        users = users.where("name like ?", "%#{name}%") if name.present?
        users = users.where(profileable_type: type) if type.present?

        if (location_type == 'city' && city.present?)
          users = users.joins(:address).where(addresses: {city: city})
        elsif (location_type == 'province' && province.present?)
          users = users.joins(:address).where(addresses: {province: province})
        elsif (location_type == 'region' && region.present?)
          users = users.joins(:address).where(addresses: {region: region})
        end
      end

      return users.order(:name)
    end
end
