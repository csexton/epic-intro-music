class Broadcast
  attr_reader :url, :data

  def initialize(data)
    @data = data
    @url = "http://requestb.in/1ern5o91"
  end

  def send
    NSLog "### Broadcast: send"
    BW::HTTP.post(url, { payload: data }) do |response|
      NSLog "### Broadcast: send response: #{response}"
    end
  end
end
