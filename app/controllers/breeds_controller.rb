class BreedsController < ApplicationController

  def index
    @breed = DogBreedFetcher.fetch
    @names = DogBreedFetcher.names
  end

end
