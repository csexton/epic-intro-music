require "open-uri"
require "pathname"
require "fileutils"

class FileCache
  attr_reader :url
  def initialize(url)
    @url = url
  end

  def path
    File.exists?(file_path) ? file_path : download
  end

  private

  def download
    open(file_path, "wb") do |file|
      file << open(url).read
    end
    file_path
  end

  def temp_dir
    Pathname.new(File.join(File.dirname(__FILE__), "..", "tmp"))
  end

  def file_name
    File.basename(url)
  end

  def file_path
    File.expand_path(temp_dir.join(file_name))
  end
end
