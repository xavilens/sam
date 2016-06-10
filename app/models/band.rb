class Band < ActiveRecord::Base
  has_one :user, as: :profileable
  belongs_to :genre1, class_name: 'Genre'
  belongs_to :genre2, class_name: 'Genre'
  belongs_to :genre3, class_name: 'Genre'

  # TODO: Campo Estado = {buscando miembros, buscando conciertos, ninguno}
end
