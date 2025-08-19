namespace :organizations do 
  
  # be rake organizations:init --trace
  task :init => :environment do
    Rake::Task["organizations:seed"].invoke
    Rake::Task["organizations:metrics"].invoke
  end
  
  # be rake user:seed --trace
  task :seed => :environment do
    
    organizations = []
    
    # t.string :name
    # t.string :fid
    # t.boolean :active, default: true
    # t.references :secure_chat_system, null: false, foreign_key: true
    # t.string :billing
    # t.string :city
    # t.string :state
    # t.string :organization_website_url
    # t.string :organization_website_domain
    # t.string :your_domain_or_ours
    # t.references :domain, null: false, foreign_key: true
    # t.string :sub_domain
    # t.string :polly_domain
    # t.string :polly_url
    # t.text :features
    # t.timestamps
    
    organizations << OpenStruct.new(
      name: "Team",
      fid: "team",
      first_name: "Scott",
      last_name: "Johnson",
      email: "fuzzygroup@gmail.com",
      password: "foo1234",
      password_confirmation: "foo1234",
      username: "fuzzygroup",
      active: true,
      secure_chat_system_id: SecureChatSystem.signal.id,
      billing: 'free',
      city: 'fishers',
      state_id: State.indiana.id,
      organization_website_url: 'https://www.pollitify.com',
      organization_website_domain: 'pollitify.com',
      use_pollitify_base_domain: true,
      domain_id: Domain.pollitify.id,
      sub_domain: 'team',
      polly_domain: 'team.pollitify.com',
      polly_url: 'https://team.pollitify.com',
      features: "{}",
      domain_id: Domain.pollitify.id
    )
    
    organizations << OpenStruct.new(
      name: "Blythe Potter Save Our State",
      first_name: "Blythe",
      last_name: "Potter",
      email: "fuzzygroup@gmail.com",
      password: "foo1234",
      password_confirmation: "foo1234",
      username: "blythe",
      fid: "sosindiana",
      active: true,
      secure_chat_system_id: SecureChatSystem.signal.id,
      billing: 'free',
      city: 'fishers',
      state_id: State.indiana.id,
      organization_website_url: 'https://www.sosindiana.com/',
      organization_website_domain: 'sosindiana.com',
      use_pollitify_base_domain: false,
      domain_id: nil,
      sub_domain: 'pollitify',
      polly_domain: 'pollitify.sosindiana.com',
      polly_url: 'https://pollitify.sosindiana.com',
      features: "{}",
      domain_id: Domain.your_own_domain.id
    )
    
    add_organizations(organizations)
  end
  
  def add_organizations(organizations) 
    organizations.each do |struct|
      puts "Processing Organization:\n   #{struct.name}"
      
      status, organization = Organization.find_or_create(struct)

    end
  end



  # be rake speaker:metrics
  task :metrics => :environment do
    klass = "Organization"
    puts "For object: #{klass.to_s}, there are #{klass.constantize.count} objects in the database"
  end
  
end

