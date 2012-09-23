require 'rspec/core/rake_task'

file_list = FileList['spec/*_spec.rb']

namespace :test do
  RSpec::Core::RakeTask.new('spec') do |t|
    t.pattern = file_list
    t.rspec_opts = ["--colour", "--format progress", "-p"]
  end
end
desc 'Default: run specs.'
task :default => 'test:spec'

namespace :deploy do

  ## name and version taken from 
  ## https://github.com/mojombo/rakegem
  def name
    @name ||= Dir['*.gemspec'].first.split('.').first
  end

  def version
    line = File.read("lib/#{name}.rb")[/^\s*VERSION\s*=\s*.*/]
    line.match(/.*VERSION\s*=\s*['"](.*)['"]/)[1]
  end

  desc 'Run Spec'
  html_path = "spec_results.html"  
  RSpec::Core::RakeTask.new('run_spec') do |t|
    t.pattern    = file_list
    t.rspec_opts = ["--format html", "--out #{html_path}"]
  end


  desc 'Check that the spec passes'
  task :spec_passes => :run_spec do
    # find out how many errors were found  
    html     = open(html_path).read  
    examples = html.match(/(\d+) examples/)[0].to_i rescue 0  
    failures = html.match(/(\d+) failures/)[0].to_i rescue 0  
    pending  = html.match(/(\d+) pending/)[0].to_i rescue 0  

    if failures.zero?  
      puts "0 failures! #{examples} run, #{pending} pending"  
    else  
      $stderr.puts "\aSpecs did not pass deploy aborted!"  
      $stderr.puts "View spec results at #{File.expand_path(html_path)}"  
      $stderr.puts  
      $stderr.puts "#{failures} failures! #{examples} run, #{pending} pending"  
      exit -1  
    end
  end

  task :build_gem do
    puts "Building Gem"
    `gem build #{name}.gemspec`
    unless $?.success?
        $stderr.puts "Gem Build Failed"
        exit -1
    end

  end

  task :push_gem do
    puts "Pushing Gem #{name}-#{version}"
    `gem push #{name}-#{version}.gem`
    unless $?.success?
        $stderr.puts "Gem Push Failed"
        exit -1
    end    
  end

  task :create_git_tag do
    puts "Tagging #{name}-#{version}"
    `git tag -a #{version} -m 'Tagging gem release #{version}'`
    unless $?.success?
        $stderr.puts "Tagging Git Failed"
        exit -1
    end    
  end

  task :push_tag do
    puts "Push Tag #{version}"
    `git push origin #{version}`
    unless $?.success?
        $stderr.puts "Pushing Git Tag Failed"
        exit -1
    end    
  end

  task :gem => [:spec_passes, :build_gem, :push_gem, :create_git_tag, :push_tag] do
    puts "Deployed #{name} Version #{version} !"
  end

end
