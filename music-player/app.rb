require "rubygems"
require "bundler"

Bundler.require
Dir["#{File.dirname(__FILE__)}/lib/*.rb"].each {|file| require file }

def play(file)
  AudioPlayer.new(file).play
end

get "/" do
  <<-END
    <html>
      <form action="/" method="post">
        <input name="url" value="http://www.freespecialeffects.co.uk/soundfx/sirens/police_s.wav">
        <button>Play</button>
      </form>
    </html>
  END
end

post "/" do
  if params["url"]
    play FileCache.new(params["url"]).path
  end
  "Yay!"
end
