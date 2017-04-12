class EventSearchForm
  include ActiveModel::Model

  attr_accessor :name, :start_date, :finish_date, :type, :status, :location_type, :city, :province, :region
  attr_reader :events

  def initialize fields = {}
    @type = []
    @status = []

    fields.each do |field, value|
      if field == 'type'
        value.delete("")
        value.each {|val| type << val.to_i}
      elsif field == 'status'
        value.delete("")
        value.each {|val| status << val.to_i}
      elsif EventSearchForm.attribute_method? field.to_sym
        public_send("#{field}=",value)
      end
    end
  end

  # Indica si se ha rellenado algún campo de la búsqueda
  def empty?
    name.blank? && start_date.blank? && finish_date.blank? && type.blank? && status.blank? && location_type.blank? && city.blank? && province.blank? && region.blank?
  end

  # Devuelve los eventos encontrados
  def events model
    @events ||= find_events model
  end

  private
    # Búsqueda de eventos según parámetros de búsqueda
    # http://railscasts.com/episodes/111-advanced-search-form-revised
    def find_events model
      events = model.order(:date)
      events = events.where("name like ?", "%#{name}%") if name.present?
      events = events.where("date >= ?", start_date.to_s(:default)) if start_date.present?
      events = events.where("date <= ?", finish_date.to_s(:default)) if finish_date.present?
      events = events.where(event_status_id: status) if status.present?
      events = events.where(event_type_id: type) if type.present?

      if (location_type = 'city' && city.present?)
        events = events.joins(:address).where(addresses: {city: city})
      elsif (location_type = 'province' && province.present?)
        events = events.joins(:address).where(addresses: {province: province})
      elsif (location_type = 'region' && region.present?)
        events = events.joins(:address).where(addresses: {region: region})
      end

      return events
    end
end