require "json"

class ConfigFile
  attr_reader :fname

  def initialize(fname)
    @fname = fname
  end

  def load
    if File.exist?(fname)
      JSON.load(File.read(fname), symbolize_names: true)
    else
      raise "JSON syntax error occurred while parsing #{fname}"
    end
  end
end
