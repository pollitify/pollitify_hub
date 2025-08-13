namespace :code do
  desc "Check Ruby files for syntax errors"
  task :syntax do
    failed = false
    Dir.glob("**/*.rb").each do |file|
      next if File.directory?(file)
      result = `ruby -c #{file} 2>&1`
      unless result.include?("Syntax OK")
        puts "[ERROR] #{file}:\n#{result}"
        failed = true
      end
    end
    abort("Syntax errors found!") if failed
    puts "All Ruby files passed syntax check."
  end
end