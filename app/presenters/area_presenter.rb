class AreaPresenter

  delegate :attractions, :name, :image, to: :area

  def initialize(area)
    @area = area
  end

  def proposed_date
    area.proposed_date.strftime('%A, %e %B %Y') if area.proposed_date.present?
  end

  def total
    area.total.format
  end

  def description
    area.description.
      # preserve paragraph breaks
      gsub("\n", '<br/>').
      # convert links into ..links!
      gsub(/(http[s]?:\/\/[^\s]*)/, '<a href="\1">\1</a>').
      html_safe if area.description.present?
  end

private

  attr_reader :area

end
