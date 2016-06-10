class Band < ActiveRecord::Base
  belongs_to :genre1, class_name: :genre
  belongs_to :genre2, class_name: :genre
  belongs_to :genre3, class_name: :genre
end
