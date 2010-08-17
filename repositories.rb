@repositories = Hash.new{|h,k| h[k] = []}

def add(label, path, repository_type=Qwandry::FlatRepository)
  label = label.to_s
  @repositories[label] << repository_type.new(label, path)
end

# Add gem repositories:
# Using the ruby load paths, determine the common gem root paths, and add those.
# This assumes gem paths look like:
($:).grep(/gems/).map{|p| p[/.+\/gems\//]}.uniq.each do |path|
  add :gem, path
end

# Add ruby standard libraries, ignore the platform specific ones since they
# tend to contain only binaries
($:).grep(/lib\/ruby/).reject{|path| path =~ /#{RUBY_PLATFORM}$/}.each do |path|
  add :ruby, path
end