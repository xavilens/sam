require 'delegate'

class EventPresenter < SimpleDelegator
  def self.wrap(collection)
    collection.map do |obj|
        new obj
    end
  end

  def location
    "#{event.city}, #{event.state}"
  end

  def type
    "#{event.event_type.name}"
  end

  def description
    (event.description.gsub(/\n/, '<br/>')).html_safe
  end

  def event
    __getobj__
  end
end
