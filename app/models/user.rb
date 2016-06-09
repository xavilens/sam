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
  # validates :rol_id, presence: true, foreign_key: :rol
  validates :profileable_id, presence: true
  validates :profileable_type, presence: true, uniqueness: {scope: :profileable_id}

  has_one :rol
  belongs_to :userable, polymorphic: true

  before_create :rolPorDefecto

  private
    def rolPorDefecto
      self.rol ||= Rol.find_by_descripcion('registrado')
    end
end
