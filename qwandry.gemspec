Gem::Specification.new do |s|
  s.name               = "qwandry"
  s.version            = "0.1.5"
  s.summary            = "Qwandry lets you quickly edit ruby gems and libraries"
  s.description        = "Open a gem or library's source directory with your default editor."
  s.email              = "netghost@gmail.com"
  s.authors            = ["Adam Sanderson"]
  s.date               = "2013-01-06"
  s.executables        = ["qw"]
  s.default_executable = "qw"
  s.require_paths      = ["lib"]
  s.extra_rdoc_files   = ["README.markdown"]
  s.files              = Dir["{bin,lib,templates}/**/*"] + ["Rakefile", "README.markdown"]
  s.homepage           = "http://github.com/adamsanderson/qwandry"
  s.rdoc_options       = ["--charset=UTF-8"]  
end