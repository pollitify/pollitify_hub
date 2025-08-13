namespace :domains do 
  
  # be rake domains:init --trace
  task :init => :environment do
    Rake::Task["domains:seed"].invoke
    Rake::Task["domains:metrics"].invoke
  end
  
  # be rake user:seed --trace
  task :seed => :environment do
    
    all_domains = []
    
    all_domains << "pollitify.com"
    all_domains << "pollytical.com"
    all_domains << "pollitify.org"
    all_domains << "pollytical.org"
    all_domains << "pollytics.org"
    
    all_domains = all_domains.sort
    
    domains = []

    all_domains.each do |domain|
      domains << 
      OpenStruct.new(
        name: domain
      )
    end
    
    add_domains(domains)
  end
  
  def add_domains(domains) 
    domains.each do |domain_struct|
      puts "Processing Domain:\n   #{domain_struct.name}"
      
      status, domain = Domain.find_or_create(domain_struct)

    end
  end



  # be rake speaker:metrics
  task :metrics => :environment do
    klass = "Domain"
    puts "For object: #{klass.to_s}, there are #{klass.constantize.count} objects in the database"
  end
  
end

