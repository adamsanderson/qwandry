@repositories = Hash.new{|h,k| h[k] = []}

def which(bin)
  `which #{bin}`.chomp
end

def add(repository, path=nil)
  if !path
    path = repository
    repository = 'default'
  end

  @repositories[repository] << path 
end

if which('ruby') == '/Users/adam/.rvm/rubies/ruby-1.9.1-p378/bin/ruby'
  add 'gem', '/Users/adam/.rvm/gems/ruby-1.9.1-p378/gems/'
end