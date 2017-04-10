# class EventSearchForm < Reform::Form
class EventSearchForm
  include ActiveModel::Model

  attr_accessor :name, :start_date, :finish_date, :type, :status, :location_type, :city, :province, :region

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

  def empty?
    name.blank? && start_date.blank? && finish_date.blank? && type.blank? && status.blank? && location_type.blank? && city.blank? && province.blank? && region.blank?
  end
end
