namespace :features do 
  
  # be rake features:init --trace
  task :init => :environment do
    Rake::Task["features:seed"].invoke
    Rake::Task["features:metrics"].invoke
  end
  
  # be rake user:seed --trace
  task :seed => :environment do
    
    features = []
    
    # features << OpenStruct.new(
    #   name: '',
    #   fid: '',
    #   feature_category_id: '',
    #   description: ''
    # )
    
    features << OpenStruct.new(
      name: 'Security Checkin',
      fid: 'security_checkin',
      feature_category_id: FeatureCategory.security.id,
      description: 'Have problems with Counter Protestors following your people home after events?  Security Checkins helps you manage the process of checking in with people after they get home from an event and making sure that they got home safe thru an easy to remember authenticated token.'
    )
    
    features << OpenStruct.new(
      name: 'Drone Review',
      fid: 'drone_review',
      feature_category_id: FeatureCategory.security.id,
      description: 'A lot of events these days fly drones for event photography.  The Drone Review feature lets you capture your drone footage online so your security team can look for threats.'
    )
    
    features << OpenStruct.new(
      name: 'Bank Deposits',
      fid: 'bank_deposits',
      feature_category_id: FeatureCategory.financial.id,
      description: "While we don't want to admit it, finances matter even in grass roots activism.  Even something as simple as t-shirt sales requires a bank account and deposits to be made.  The bank deposits feature lets information about you organization's financial status be shared as needed."
    )
    
    features << OpenStruct.new(
      name: 'Loans',
      fid: 'loans',
      feature_category_id: FeatureCategory.financial.id,
      description: "When you do grass roots activism, how do you keep track of the money that you spend on behalf of the organization?  Let's give an example -- You spend $71.39 to fill up the gas tank of a vehicle used to move stuff for a protest.  As an individual protestor, you shouldn't be on the hook for that money.  The loans feature lets you submit a loan to be approved and then a cryptographic signature validates the debt.  While it isn't guaranteed that you get repaid, it at least lets you record the debt in the hopes of repayment."
    )
    
    features << OpenStruct.new(
      name: 'Locally Owned',
      fid: 'locally_owned',
      feature_category_id: FeatureCategory.general.id,
      description: "One of the most powerful political actions is nothing more than being intentional about your spending choices.  Don't go to StarBucks -- support a local coffee shop and keep profits in your local community.  But which local coffee shop is actually aligned with your beliefs?  The Locally Owned feature lets you highlight and promote locally owned businesses that are allies."
    )

    features << OpenStruct.new(
      name: 'Events',
      fid: 'events',
      feature_category_id: FeatureCategory.events.id,
      description: "At the beating heart of all grass roots activism work are events.  The #{BASE_PRODUCT_NAME} Events Builder is state of the art allowing for events, speakers, speeches, musicians, multiple types of events and more."
    )

    features << OpenStruct.new(
      name: 'Meeting Notes',
      fid: 'meeting_notes',
      feature_category_id: FeatureCategory.office.id,
      description: "Grass Roots activism isn't all 'show up for a protest and depart'.  The reality is actually a lot of planning, meetings and collaboration.  And because meetings are generally virtual, notes need to be captured.  To support both a horizontal leadership model as well as a top down leadership model, meeting notes need to be captured and shared in an easily searchable fashion."
    )
    
    features << OpenStruct.new(
      name: 'Contact Cards',
      fid: 'contact_cards',
      feature_category_id: FeatureCategory.office.id,
      description: "One of the harder things to understand about Grass Roots Activism is that the cause is more important than any single individual in the cause.  Resources developed during activism belong to the cause not to an individual.  Consider the case of a press contact for a key reporter at the local paper -- who owns that?  Should it just exist on the phone of the person who happened to talk to them?  Or should that contact be shared to the organization as a whole so anyone can contact them?  Contact Cards enable contacts to be captured, organized and tagged so everyone has access."
    )

    features << OpenStruct.new(
      name: 'Get Elected',
      fid: 'get_elected',
      feature_category_id: FeatureCategory.get_elected.id,
      description: "The Get Elected features aren't for every grass roots organizations -- they are for politicians looking to get elected.  Whether you are running as Mayor of your small town or for Secretary of State, it is all still creating and executing on a political campaign.  "
    )

    features << OpenStruct.new(
      name: 'Raise Funds',
      fid: 'raise_funds',
      feature_category_id: FeatureCategory.raise_funds.id,
      description: "Fund Raising is the Voldemort of grass roots activism -- that which shall not be named -- but it is still needed.  Putting on events isn't free.  Everything from the permit to bottles of water needs to be paid for and the Fund Raising features in #{BASE_PRODUCT_NAME} make that possible."
    )
    
    features << OpenStruct.new(
      name: 'Chat Messages',
      fid: 'general',
      feature_category_id: FeatureCategory.general.id,
      description: "In many group contexts where chat is a dominant means of communication, brilliant ideas emerge.  The Chat Messages feature allows you to archive messages for posterity into a permanently searchable knowledge base."
    )
    
    features << OpenStruct.new(
      name: 'Research',
      fid: 'research',
      feature_category_id: FeatureCategory.research.id,
      description: "Do you know exactly who your Representatives are, who your Senators are?  Do you know their background on Open Secrets?  Do you know what's written in Wikipedia about the leadership that governs you?  Do you know how to contact them?  Our research feature gives you immediate access to all this vital information.  This helps you organize your members to do things like contact Representatives and Senators to lobby for change."
    )
    
    features << OpenStruct.new(
      name: 'Group Communications',
      fid: 'group_communications',
      feature_category_id: FeatureCategory.group_communications.id,
      description: "A contact database is useful but what's more useful is our Group Communications features which lets you easily text or email large numbers of people."
    )
    
    features << OpenStruct.new(
      name: 'Protest Alerts',
      fid: 'protest_alerts',
      feature_category_id: FeatureCategory.group_communications.id ,
      description: "Protest Alerts lets people sign up to be automatically texted or emailed the details of the next protest."
    )

    add_features(features)
  end
  
  def add_features(features) 
    features.each do |feature_struct|
      puts "Processing Feature:\n   #{feature_struct.name}"
      
      status, feature = Feature.find_or_create(feature_struct)

    end
  end



  # be rake speaker:metrics
  task :metrics => :environment do
    klass = "Feature"
    puts "For object: #{klass.to_s}, there are #{klass.constantize.count} objects in the database"
  end
  
end

