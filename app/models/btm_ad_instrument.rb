class BtmAdInstrument < ActiveRecord::Base
  ################### VALIDACIONES ###################
  validates :band_to_member_id, presence: true
  validates :instrument_id, presence: true, uniqueness: { scope: :band_to_member_id }

  ################### RELACIONES ###################
  belongs_to :band_to_members
  belongs_to :instruments

end
