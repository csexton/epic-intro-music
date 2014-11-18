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
        <input name="name" value="imperial-march">
        <button>Play</button>
      </form>
    </html>
  END
end

post "/" do
  if params["name"]
    play NameFile.new(params["name"]).path
  end
  <<-END
    <html>
      <p>"Yay!"</p>
      <form action="/" method="post">
        <input name="name" value="imperial-march">
        <button>Play</button>
      </form>
    </html>
  END
end
