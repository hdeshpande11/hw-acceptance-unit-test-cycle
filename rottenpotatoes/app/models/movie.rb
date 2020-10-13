class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
  def self.same_director(movie_id)
    movie = Movie.find(movie_id)
    if movie.director.blank?
      return nil
    else
      self.all.where(director: movie.director)
    end
  end  
end
