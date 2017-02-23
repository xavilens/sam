class Member < ActiveRecord::Base
  ######## VALIDATIONS
  validates :band_id, presence: true
  validates :musician_id, presence: true
  validates :instrument_id, presence: true, uniqueness: {scope: [:band_id, :musician_id]}

  ######## RELATIONSHIPS
  belongs_to :band
  belongs_to :musician
  belongs_to :instrument

  ######## METHODS
  # Devuelve el usuario cuyo perfil sea el contrario al actual
  def user current_user
    user_aux = if current_user.musician?
      band.user
    else
      musician.user
    end

    return UserDecorator.new(user_aux)
  end

end
