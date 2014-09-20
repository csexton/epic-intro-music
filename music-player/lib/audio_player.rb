require 'ptools' # for File.which
class AudioPlayer
  attr_reader :file
  def initialize(file)
    @file = file
  end

  def play
    if File.which('afplay')
      puts "playing #{file}"
      `afplay "#{file}"`
    end
  end
end
