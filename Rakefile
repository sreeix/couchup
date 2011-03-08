require 'bundler'
Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |r|
	r.rspec_opts = ["--color", "--format", "progress"]
end

task :default => :spec