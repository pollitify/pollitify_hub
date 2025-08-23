namespace :user_roles do 
  
  # be rake user_roles:init --trace
  task :init => :environment do
    Rake::Task["user_roles:seed"].invoke
    Rake::Task["user_roles:metrics"].invoke
  end
  
  # be rake user:seed --trace
  task :seed => :environment do
    
    user_role_structs = []
    
    users = []
    users << User.scott
    users << User.alex if User.alex
    users << User.taelar if User.taelar
    users << User.kayla if User.kayla
    
    Role.all.each do |role|
      users.each do |user|
        #debugger
        user_role_struct = OpenStruct.new(
          role_id: role.id,
          user_id: user.id
        )
        user_role_structs << user_role_struct
      end
    end
    #debugger
    add_user_roles(user_role_structs)
  end
  
  def add_user_roles(user_role_structs) 
    user_role_structs.each do |user_role_struct|
      puts "Processing Role Struct:\n   #{user_role_struct.user_id} | #{user_role_struct.role_id}"
      
      status, user_role = UserRole.find_or_create(user_role_struct)
      debugger
    end
  end



  # be rake speaker:metrics
  task :metrics => :environment do
    klass = "Role"
    puts "For object: #{klass.to_s}, there are #{klass.constantize.count} objects in the database"
  end
  
end

