class Broadcast
  EPIC_URL = "http://13e68089.ngrok.com"

  def send(data)
    BW::HTTP.post(url, { payload: data }) do |response|
      puts response.status_code
    end
  end
end
