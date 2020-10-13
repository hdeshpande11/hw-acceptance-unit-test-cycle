require 'spec_helper'
require 'rails_helper'

RSpec.describe Movie, type: :model do
    describe '.same_director' do
    let!(:movie1) { FactoryGirl.create(:movie, title: 'Zindagi Na Milegi Dobara', director: 'Zoya Akhtar') }
    let!(:movie2) { FactoryGirl.create(:movie, title: 'Queen', director: 'Vikas Bahl') }
    let!(:movie3) { FactoryGirl.create(:movie, title: 'Dil Dhadakne Do', director: 'Zoya Akhtar') } 
    let!(:movie4) { FactoryGirl.create(:movie, title: 'NoDirector')}

    it 'finds similar movies correctly if director exists' do
        expect(Movie.same_director(movie1.id)).to contain_exactly(movie1, movie3)
        expect(Movie.same_director(movie1.id)).to_not match(movie2)
        expect(Movie.same_director(movie2.id)).to contain_exactly(movie2)
    end
   
     
    
    it 'will handle sad path if director does not exist' do
        expect(Movie.same_director(movie4.id)).to eql(nil)
    end
     
  end
  
  
    describe '.all_ratings' do
      it 'returns all ratings' do
       expect(Movie.all_ratings).to match(%w(G PG PG-13 NC-17 R))
       end
    end
end
