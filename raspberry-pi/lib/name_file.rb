require "pathname"
require "fileutils"

class NameFile

  attr_reader :name
  def initialize(name)
    @name = name
  end

  def path
    if File.exists?(file_path "mp3")
      file_path "mp3"
    elsif File.exists?(file_path "wav")
      file_path "wav"
    else
      raise "ZOMG! That's not a file"
    end
  end

  private

  def temp_dir
    Pathname.new(File.join(File.dirname(__FILE__), "..", "tmp"))
  end

  def file_path(ext)
    File.expand_path(temp_dir.join("#{name}.#{ext}"))
  end
end

