class Gizmo < ActiveRecord::Base
  before_create :set_position
  before_save :apply_color_palette

  GIZMO_STATUS = %w( offline preview online )
  enum status: GIZMO_STATUS

  belongs_to :contentable, polymorphic: true
  belongs_to :content, polymorphic: true

  attr_accessor :color_palette

  validates_presence_of :position
  validates :status, inclusion: { in: GIZMO_STATUS }, presence: true

  scope :order_by_position, -> { order(:position => :asc) }
  scope :preview_or_online, -> { where('status = ? OR status = ?', statuses[:online], statuses[:preview]) }

  GIZMO_STATUS.each do |s|
    scope s, -> { where('status = ?', statuses[s.to_sym]) }
  end

  def self.color_palette
    [ ['Light Grey', 'f1f1f1'],
      ['Grey', '444444'],
      ['Dark Grey', '2f2f2f'],
      ['Red', 'e00022'] ]
  end

  def apply_color_palette
    self.background_color = self.color_palette if self.color_palette.present?
  end

  def with_same_contentable
    self.class.where(:contentable_id => self.contentable_id, :contentable_type => self.contentable_type).order_by_position
  end

  def set_position
    self.position = (self.with_same_contentable.last.position + 1) rescue 1
  end

  def resort_siblings!
    gizmos = self.with_same_contentable
    gizmos.each_with_index do |gizmo, i|
      gizmo.update_attribute(:position, i + 1)
    end
  end

  def status_color
    color = 'success' if self.online?
    color = 'important' if self.offline?
    color ||= 'warning'
  end

end
