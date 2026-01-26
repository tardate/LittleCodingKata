#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
puts "Running with Ruby #{RUBY_VERSION}"

task default: %i[setup run_rubies run_rspecs extra]

RB_SKIP = FileList[] unless defined?(RB_SKIP)
SPEC_SKIP = FileList[] unless defined?(SPEC_SKIP)

desc "Run all of the rspecs in this directory."
if defined?(DISABLE_RSPECS) and DISABLE_RSPECS
  task :run_rspecs do
    puts "\nRspecs disabled for this directory\n\n"
  end
else
  task :run_rspecs do
    rspecs = FileList["*_spec.rb"] - SPEC_SKIP
    puts "Running specs in #{__dir__}"
    sh "bundle exec rspec #{rspecs}"
  end
end

desc "Run all of the Ruby files in this directory."
if defined?(DISABLE_RUBYS) and DISABLE_RUBYS
  task :run_rubies do
    puts "Rubys disabled for this directory"
  end
else
  task :run_rubies do
    puts "Running ruby files in #{__dir__}"
    rubies = FileList["*.rb"] - FileList["*_spec.rb"]
    rubies -= RB_SKIP
    rubies.each do |rfile|
      sh "bundle exec ruby #{rfile}"
    end
  end
end

desc "Do any prep work."
task :setup

desc "Run any directory specific tasks."
task :extra

desc "Clean up the mess we have made running things."
task :clean
