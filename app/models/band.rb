class Band < ActiveRecord::Base

  ################### RELACIONES ###################
  has_one :user, as: :profileable

  # TODO: Soft-delete?? Historial de musicos??
  has_many :members, dependent: :delete_all
  has_many :musicians, through: :members

  belongs_to :genre1, class_name: 'Genre', foreign_key: "genre_id"
  belongs_to :genre2, class_name: 'Genre', foreign_key: "genre_id"
  belongs_to :genre3, class_name: 'Genre', foreign_key: "genre_id"

  # TODO: Campo Estado = {buscando miembros, buscando conciertos, ninguno}
end
