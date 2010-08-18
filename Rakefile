require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "qwandry"
    s.summary = "Qwandry lets you quickly edit ruby gems and libraries"
    s.description = <<-DESC
      Open a gem or library's source directory with your default editor.
    DESC
    s.email = "netghost@gmail.com"
    s.homepage = "http://github.com/adamsanderson/qwandry"
    s.authors = ["Adam Sanderson"]
    s.has_rdoc = false
    s.files = FileList["[A-Z]*", "{bin,lib,test}/**/*"]
    
    # Testing
    s.test_files = FileList["test/**/*_test.rb"]
  end

rescue LoadError
  puts "Jeweler not available. Install it for jeweler-related tasks with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

Rake::TestTask.new do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end

task :default => :test
