class DogBreedFetcher
  attr_reader :breed

  def initialize(name=nil)
    @name  = name || "random"
    @breed = Breed.find_or_initialize_by(name: name)
  end

  def fetch
    return @breed if @breed.pic_url.present?

    @breed.pic_url = fetch_info["message"]
    @breed.save && @breed
  end

  def self.fetch(name=nil)
    name ||= "random"
    DogBreedFetcher.new(name).fetch
  end

  def self.names
    begin
      body = JSON.parse(RestClient.get('https://dog.ceo/api/breeds/list/all').body)
      body['message'].reduce([]) do |names, (breed, sub_breeds)|
        if sub_breeds.empty?
          names.concat([breed])
        else
          names.concat(sub_breeds.map { |e| [breed, e].join('/') })
        end
      end 
    rescue Object => e
      []
    end
  end

private
  def fetch_info
    begin
      JSON.parse(RestClient.get(api_url).body)
    rescue Object => e
      default_body
    end
  end

  def default_body
    {
      "status"  => "success",
      "message" => "https://images.dog.ceo/breeds/cattledog-australian/IMG_2432.jpg"
    }
  end

  def api_url
    if @name == 'random'
      'https://dog.ceo/api/breeds/image/random'
    else
      "https://dog.ceo/api/breed/#{@name}/images/random"
    end
  end
end
