begin
  require 'rspec/core/rake_task'
  require 'cucumber/rake/task'

  namespace :app do
  
    desc "Run specs into HTML"
    RSpec::Core::RakeTask.new(:specs) do |t|
      t.rspec_opts = ["-f html", "-o public/specs.html"]
      t.pattern = 'spec/**/*_spec.rb'
    end
  
    desc "Run features into HTML"
    Cucumber::Rake::Task.new({:features => 'db:test:prepare'}, 'Run features into HTML') do |t|
      t.fork = true # You may get faster startup if you set this to false
      t.profile = 'html'
    end
  end

rescue LoadError
  desc 'rake task not available in this environment'
  task :app do
    abort 'rake task is not available in this environment'
  end
  
end
