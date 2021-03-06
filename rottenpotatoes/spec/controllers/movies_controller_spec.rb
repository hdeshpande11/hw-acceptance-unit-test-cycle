require 'rails_helper'


RSpec.describe MoviesController, type: :controller do
    
  describe 'finding similar movies' do
      let!(:movie) { FactoryGirl.create(:movie) }
      let!(:movie1) { FactoryGirl.create(:movie, title: 'Zindagi Na Milegi Dobara', director: 'Zoya Akhtar') }
      let!(:movie2) { FactoryGirl.create(:movie, title: 'Queen', director: 'Vikas Bahl') }
      let!(:movie3) { FactoryGirl.create(:movie, title: 'Dil Dhadakne Do', director: 'Zoya Akhtar') }
      let!(:movie4) { FactoryGirl.create(:movie, title: 'NoDirector')}
     
       
      it 'should find the movie using the id' do
        get :similar, id: movie.id
        expect(assigns(:movie)).to eql(movie)
      end
     
      it 'should call same_director method' do
       
       Movie.stub(:same_director).with(movie1.id).and_return([movie1,movie3])
       get :similar,  id: movie1.id
       expect(assigns(:movies)).to contain_exactly(movie1,movie3)
       
       Movie.stub(:same_director).with(movie4.id).and_return(nil)
       get :similar, id: movie4.id
       expect(assigns(:movies)).to eql(nil)
       
      end
      
      
      it 'should redirect to homepage and display flash message if the movie has no director in the database' do
       
       get :similar,  id: movie4.id
       expect(response).to redirect_to(movies_path)
       expect(flash[:warning]).to eq("\"'#{movie4.title}' has no director info\"")
      end
      
    
      
      it 'should render the similar template if director exists' do
        get :similar,  id: movie1.id
        expect(response).to render_template('similar')
      end
      
      
  end
  
  describe 'create' do
   it 'should create new movie with given attributes' do
    base = {title: "New_Movie", rating: "PG", director:"Some_Person"}
    expect{post :create, movie: base}.to change(Movie, :count).by(1)
   end
   
   it 'should redirect to homepage after movie creation' do
    base = {title: "New_Movie", rating: "PG", director:"Some_Person"}
    post :create, movie: base
    expect(response).to redirect_to(movies_path)
   end
  end
  
  describe 'index' do
    let!(:movie) {FactoryGirl.create(:movie)}
     it 'should render the index template' do
      get :index
      expect(response).to render_template('index')
    end
     
  end
 
  
  describe 'show' do
    let!(:movie) { FactoryGirl.create(:movie) }
    it 'should find the movie' do
     get :show, id: movie.id
      expect(assigns(:movie)).to eql(movie)
    end
     it 'should render the show template' do
       get :show, id: movie.id
      expect(response).to render_template('show')
    end
  end
  
  describe 'edit' do
    let!(:movie) { FactoryGirl.create(:movie) }
     it 'should find the movie' do
      get :edit, id: movie.id
      expect(assigns(:movie)).to eql(movie)
    end
     it 'should render the edit template' do
      get :edit, id: movie.id
      expect(response).to render_template('edit')
    end
  end
  
  describe 'update' do
    let!(:movie1) { FactoryGirl.create(:movie) }
     it 'should update an existing movie with new attributes' do
      put :update, id: movie1.id, movie: FactoryGirl.attributes_for(:movie, title: 'New_Title')
      movie1.reload
      expect(movie1.title).to eql('New_Title')
    end
     it 'should redirect to the movie page' do
      put :update, id: movie1.id, movie: FactoryGirl.attributes_for(:movie, title: 'New_Title')
      expect(response).to redirect_to(movie_path(movie1))
    end
  end
  

  
  describe 'destroy' do
    let!(:movie1) { FactoryGirl.create(:movie) }
     
    it 'should destroy a movie' do
     expect { delete :destroy, id: movie1.id}.to change(Movie, :count).by(-1)
    end
     it 'should redirect to homepage after destroy' do
      delete :destroy, id: movie1.id
      expect(response).to redirect_to(movies_path)
    end
  end


end
