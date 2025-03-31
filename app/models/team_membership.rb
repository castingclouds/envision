class TeamMembership < ApplicationRecord
  belongs_to :user
  belongs_to :team

  # Constants for roles
  ROLES = %w[admin member viewer].freeze

  # Validations
  validates :role, presence: true, inclusion: { in: ROLES }
  validates :user_id, uniqueness: { scope: :team_id, message: "is already a member of this team" }

  # Default values
  attribute :role, :string, default: 'member'

  # Scopes
  scope :admins, -> { where(role: 'admin') }
  scope :members, -> { where(role: 'member') }
  scope :viewers, -> { where(role: 'viewer') }

  # Helper methods
  def admin?
    role == 'admin'
  end

  def member?
    role == 'member'
  end

  def viewer?
    role == 'viewer'
  end
end
