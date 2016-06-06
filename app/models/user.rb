class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # CAMPOS: id, email, encrypted_password, nombre, ciudad, comunidad, pais,
  # userable_id, userable_type, rol_id, created_at, updated_at

  #CAMPOS DEVISE: reset_password_token, reset_password_sent_at,
  # remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at,
  # current_sign_in_ip, last_sign_in_ip

  validates :ciudad, presence: true
  validates :comunidad, presence: true
  validates :pais, presence: true
  validates :rol_id, presence: true, foreign_key: :roltatus
  validates :userable_id, presence: true
  # Con validates campoX uniqueness: {scope: campoY} creamos unicidad en la tupla de campos {campoX, campoY},
  # imposibilitando crear un Usuario con valores repetidos en dicha tupla
  validates :userable_type, presence: true, uniqueness: {scope: :userable_id}

  has_one :rol
  belongs_to :userable, polymorphic: true
end
