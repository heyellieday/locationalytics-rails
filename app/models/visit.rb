class Visit < ActiveRecord::Base
  belongs_to :visitor
  belongs_to :location
  before_save :check_end

  def check_end
    if self.end_time != nil
      time_diff
    end
  end

  def time_diff
    self.length = ((self.end_time - self.start_time) / 60)
  end
end
