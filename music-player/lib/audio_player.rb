require 'ptools' # for File.which
class AudioPlayer
  attr_reader :file
  def initialize(file)
    @file = file
  end

  def play
    puts "playing #{file}"
    if File.which('afplay')
      `afplay "#{file}"`
    else File.which('mpg321')
      `mpg321 "#{file}"`
    end
  end
end
