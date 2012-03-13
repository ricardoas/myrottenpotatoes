class Movie < ActiveRecord::Base
  def self.all_ratings
    self.all(:select => "DISTINCT rating").map {|x| x.rating}
  end
end
