@repositories = Hash.new{|h,k| h[k] = []}

def which(bin)
  `which #{bin}`.chomp
end

def add(label, path, repository_type=Qwandry::FlatRepository)
  label = label.to_s
  @repositories[label] << repository_type.new(label, path)
end

#if which('ruby') == '/Users/adam/.rvm/rubies/ruby-1.9.1-p378/bin/ruby'
#  add :gem,  '/Users/adam/.rvm/gems/ruby-1.9.1-p378/gems/'
#  add :ruby, '/Users/adam/.rvm/rubies/ruby-1.9.1-p378/lib/ruby/1.9.1/'
#end

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