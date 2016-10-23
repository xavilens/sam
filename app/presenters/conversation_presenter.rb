require 'delegate'

class ConversationPresenter < SimpleDelegator
  def self.wrap(collection)
    collection.map do |obj|
        new obj
    end
  end

  def unread_messages
    current_user.conversations.unread
  end

  def formatted_time
    time = last_message_time
    "#{time.hour}:#{time.min} #{time.day} de #{time.mon} de #{time.year}"
  end

  def conversation
    __getobj__
  end
end
