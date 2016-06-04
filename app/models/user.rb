class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :userable_id, presence: true
  # Con validates campoX uniqueness: {scope: campoY} creamos unicidad en la tupla de campos {campoX, campoY},
  # imposibilitando crear un Usuario con valores repetidos en dicha tupla
  validates :userable_type, presence: true, uniqueness: {scope: :userable_id}

  belongs_to :userable, polymorphic: true
end
