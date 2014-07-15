module GizmosHandling
  extend ActiveSupport::Concern

  included do
    after_create :create_yield_gizmo
    has_many :gizmos, as: :contentable, dependent: :destroy

    def self.appendable_types
      Gizmos.config.appendable_types
    end

    def create_yield_gizmo
      self.gizmos << Gizmo.create!(
        :is_yield => true,
        :status => 'online',
        :position => 1 )
    end
  end
end
