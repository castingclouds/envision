class Team < ApplicationRecord
  # Associations
  has_many :team_memberships, dependent: :destroy
  has_many :users, through: :team_memberships

  # Validations
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  
  # Scopes
  scope :active, -> { where(active: true) }

  # Default values
  attribute :active, :boolean, default: true
end
