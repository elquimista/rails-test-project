class BreedsController < ApplicationController

  def index
    @names = DogBreedFetcher.names
    @breed_name = params[:breed_name]
    @breed = DogBreedFetcher.fetch(@breed_name.present? ? @breed_name : nil)
  end

end
