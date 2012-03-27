require 'spec_helper'

describe Movie do
  before :each do
    @dummy_id = 1
    @dummy_director = "my director"
    @dummy_movie = mock('Movie')
    @dummy_movie.stub(:director).and_return(@dummy_director)
    
    @fake_results = [mock('Movie'), mock('Movie')]
  end
  
  it 'should call find by id' do
    # Arrange
    Movie.should_receive(:find_by_id).with(@dummy_id)
      .and_return(@dummy_movie)
    
    # Act
    Movie.find_similar_movies(@dummy_id)
  end
  
  it 'should call find all by director' do
    # Arrange    
    Movie.stub(:find_by_id).and_return(@dummy_movie)
    Movie.should_receive(:find_all_by_director).with(@dummy_director)
      .and_return(@fake_results)
    
    # Act
    result = Movie.find_similar_movies(@dummy_id)
    
    # Assert
    result.should == @fake_results    
  end
end
