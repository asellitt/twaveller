class TripRight < ActiveRecord::Base
  validates_inclusion_of :permission, in: [:owner, :collaborator, :viewer], allow_nil: false

  def self.user_can_edit?(user_id: user_id, trip_id: trip_id)
    right = where(user_id: user_id, trip_id: trip_id).first
    right.present? ? right.can_edit? : false
  end

  def self.user_can_view?(user_id: user_id, trip_id: trip_id)
    right = where(user_id: user_id, trip_id: trip_id).first
    right.present? ? right.can_view? : false
  end

  def permission
    super.to_sym if super.present?
  end

  def permission=(perm)
    super(perm.to_sym)
    permission
  end

  def can_view?
    [:owner, :collaborator, :viewer].include? permission
  end

  def can_edit?
    [:owner, :collaborator].include? permission
  end
end
