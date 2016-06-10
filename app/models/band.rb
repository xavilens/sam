class Band < ActiveRecord::Base
  has_one :user, as: :profileable
  belongs_to :genre1, class_name: 'Genre', foreign_key: "genre1_id"
  belongs_to :genre2, class_name: 'Genre', foreign_key: "genre2_id"
  belongs_to :genre3, class_name: 'Genre', foreign_key: "genre3_id"

  # TODO: Campo Estado = {buscando miembros, buscando conciertos, ninguno}
end
