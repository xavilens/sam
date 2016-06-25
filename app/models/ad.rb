class Ad < ActiveRecord::Base
  belongs_to :user
  belongs_to :adeable, polymorphic: true
end
