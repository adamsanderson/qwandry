require 'rake'
require 'rake/testtask'
require 'rdoc/task'
require 'rubygems/package_task'

spec = eval(File.read('qwandry.gemspec'))

Gem::PackageTask.new(spec) do |p|
  p.gem_spec = spec
end

desc "Install the current Qwandry gem"
task "install" => [:gem] do
  path = File.join("pkg", spec.full_name)
  system 'gem', 'install', path
end

Rake::TestTask.new do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end

task :default => :test
