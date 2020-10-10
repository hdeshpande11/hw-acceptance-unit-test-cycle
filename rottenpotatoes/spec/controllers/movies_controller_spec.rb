require 'rails_helper'


RSpec.describe MoviesController, type: :controller do
    
    
#a RESTful route for Find Similar Movies

#a controller method to receive the click on "Find With Same Director",
#and grab the id (for example) of the movie that is the subject of the match (i.e. the one we're trying to find movies similar to)

#a model method in the Movie model to find movies whose director matches that of the current movie.
#Note: This implies that you should write at least 2 specs for your controller: 1) When the specified movie has a director, it should... 2) When the specified movie has no director, it should ... 
#and 2 for your model: 1) it should find movies by the same director and 2) it should not find movies by different directors.

#It's up to you to decide whether you want to handle the sad path of "no director" in the controller method or in the model method, but you must provide a test for whichever one you do.

end
