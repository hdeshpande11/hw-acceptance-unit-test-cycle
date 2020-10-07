class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
  def self.get_id(movie_name)
    self.select("id").where(:title => movie_name)
  end
end
