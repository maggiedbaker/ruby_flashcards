
module Stat

@records = {}

def self.records
  @records
end

def self.records=(new)
  @records = new
end

def self.track(item, input)
  if @records.has_key?(item)
    @records[item] << input
  else
    @records[item] = [input]
  end
end

end

