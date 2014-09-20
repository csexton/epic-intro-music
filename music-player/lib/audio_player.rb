require 'ptools' # for File.which
class AudioPlayer
  attr_reader :file
  def initialize(file)
    @file = file
  end

  def play
    case File.extname(file)
    when ".mp3"
      play_mp3
    when ".wav"
      play_wav
    else
      raise "Don't know how to play #{file}"
    end
  end

  def play_wav
    puts "playing wav #{file}"
    if File.which('afplay')
      `afplay "#{file}"`
    else File.which('mpg321')
      `aplay "#{file}"`
    end
  end

  def play_mp3
    puts "playing mp3 #{file}"
    if File.which('afplay')
      `afplay "#{file}"`
    else File.which('mpg321')
      `mpg321 "#{file}"`
    end

  end
end
