class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Validations
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }

  # Team associations
  has_many :team_memberships, dependent: :destroy
  has_many :teams, through: :team_memberships

  # Warden authentication method
  def self.authenticate(username, password)
    user = User.find_by(username: username)
    user&.valid_password?(password) ? user : nil
  end
end
