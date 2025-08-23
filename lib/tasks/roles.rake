namespace :roles do 
  
  # be rake roles:init --trace
  task :init => :environment do
    Rake::Task["roles:seed"].invoke
    Rake::Task["roles:metrics"].invoke
  end
  
  # be rake user:seed --trace
  task :seed => :environment do
    
    all_roles = []
    
    all_roles << "super_user"
    all_roles << "admin"
    all_roles << "leadership"
    all_roles << "safety"
    all_roles << "volunteer"
    all_roles << "social_media"
    all_roles << "editor"
    
    all_roles = all_roles.sort
    
    roles = []

    all_roles.each do |role|
      roles << 
      OpenStruct.new(
        name: role
      )
    end
    
    add_roles(roles)
  end
  
  def add_roles(roles) 
    roles.each do |role_struct|
      puts "Processing Role:\n   #{role_struct.name}"
      
      status, role = Role.find_or_create(role_struct)

    end
  end



  # be rake speaker:metrics
  task :metrics => :environment do
    klass = "Role"
    puts "For object: #{klass.to_s}, there are #{klass.constantize.count} objects in the database"
  end
  
end

