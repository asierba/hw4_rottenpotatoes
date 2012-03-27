require 'spec_helper'

describe MoviesController do
  describe 'find with same director' do
    before :each do
      @dummy_id = "1"
      @fake_results = [mock('Movie'), mock('Movie')]
    end
    
    it 'should call the model method that performs the search for same director' do
      # Arrange      
      Movie.should_receive(:find_similar_movies).with(@dummy_id)
        .and_return(@fake_results)

      # Act
      get :similar, { :id => @dummy_id }
    end
    
    describe 'after valid search' do
      before :each do
        # Arrange
        Movie.stub(:find_similar_movies).and_return(@fake_results)
          
        # Act
        get :similar, { :id => @dummy_id }
      end
      it 'should select the Same Director template for rendering' do  
        # Assert
        response.should render_template('similar')
      end
      it 'should make the search results availabe to that template' do        
        # Assert
        assigns(:movies).should == @fake_results
      end
    end
  end
end
