class MemberInstrument < ActiveRecord::Base
  ######## VALIDATIONS
  validates :member_id, presence: true
  validates :instrument_id, presence: true, uniqueness: {scope: :member_id}

  ######## RELATIONSHIPS
  belongs_to :member
  belongs_to :instrument
end
