namespace :secure_chat_systems do 
  
  # be rake secure_chat_systems:init --trace
  task :init => :environment do
    Rake::Task["secure_chat_systems:seed"].invoke
    Rake::Task["secure_chat_systems:metrics"].invoke
  end
  
  # be rake user:seed --trace
  task :seed => :environment do
    
    secure_chat_systems = []
    
    secure_chat_systems << OpenStruct.new(
      name: "Signal",
      fid: "signal",
      url: "https://www.signal.org/",
      description: "Signal is the premier encrypted chat system for activists world wide.  With an unbroken security track record and support for text, audio and video messaging both in 1:1 and group functionality, Signal is hard to beat."
    )
    
    secure_chat_systems << OpenStruct.new(
      name: "Discord",
      fid: "discord",
      url: "https://discord.com/",
      description: "Discord is a powerful alternative to the simple zen that is Signal.  With a series of IRC inspired features, Discord has virtually any chat feature you can imagine and the ability to create more should they be needed.  The trade off is where as Signal is clean and simple, Discord is a power user's tool."
    )
    
    secure_chat_systems << OpenStruct.new(
      name: "MatterMost",
      fid: "matter_most",
      url: "https://mattermost.com/",
      description: "If you are looking to host your own secure chat system, MatterMost is a solid choice."
    )
    
    secure_chat_systems << OpenStruct.new(
      name: "Slack",
      fid: "slack",
      url: "https://slack.com/",
      description: "Slack offers an Industry leading set of chat related features and integrations."
    )
        
    secure_chat_systems << OpenStruct.new(
      name: "Other",
      fid: "other",
      url: "tbd",
      description: ""
    )
    
    secure_chat_systems << OpenStruct.new(
      name: "Not Applicable",
      fid: "not_applicable",
      url: nil,
      description: "We're not using a secure chat system."
    )
    
    add_secure_chat_systems(secure_chat_systems)
  end
  
  def add_secure_chat_systems(secure_chat_systems) 
    secure_chat_systems.each do |struct|
      puts "Processing Secure Chat System:\n   #{struct.name}"
      
      status, secure_chat_system = SecureChatSystem.find_or_create(struct)

    end
  end



  # be rake speaker:metrics
  task :metrics => :environment do
    klass = "SecureChatSystem"
    puts "For object: #{klass.to_s}, there are #{klass.constantize.count} objects in the database"
  end
  
end

