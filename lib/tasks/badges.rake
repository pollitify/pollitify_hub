namespace :badges do 
  # be rake badges:seed --trace
  task :seed => :environment do
    # Create badges for the activism platform
    puts "Creating badges..."

    # Getting Started Badges
    Badge.find_or_create_by(name: "First Steps") do |badge|
      badge.description = "Welcome to the movement! You've shared your first post."
      badge.icon = "baby"
      badge.color = "success"
      badge.category = "getting_started"
      badge.requirement_type = "total_posts"
      badge.requirement_value = 1
      badge.active = true
    end

    Badge.find_or_create_by(name: "Getting Active") do |badge|
      badge.description = "You're building momentum with 5 posts shared!"
      badge.icon = "seedling"
      badge.color = "success"
      badge.category = "getting_started"
      badge.requirement_type = "total_posts"
      badge.requirement_value = 5
      badge.active = true
    end

    Badge.find_or_create_by(name: "Community Builder") do |badge|
      badge.description = "You're connecting! Follow 5 other activists."
      badge.icon = "users"
      badge.color = "primary"
      badge.category = "social"
      badge.requirement_type = "following_count"
      badge.requirement_value = 5
      badge.active = true
    end

    Badge.find_or_create_by(name: "Popular Activist") do |badge|
      badge.description = "People are listening! You have 10 followers."
      badge.icon = "star"
      badge.color = "warning"
      badge.category = "social"
      badge.requirement_type = "followers_count"
      badge.requirement_value = 10
      badge.active = true
    end

    # Activism Type Badges
    Badge.find_or_create_by(name: "Door Knocker") do |badge|
      badge.description = "Hit the streets! Complete 5 canvassing activities."
      badge.icon = "door-open"
      badge.color = "primary"
      badge.category = "activism_type"
      badge.requirement_type = "post_type_count"
      badge.requirement_value = 5
      badge.active = true
    end

    Badge.find_or_create_by(name: "Phone Warrior") do |badge|
      badge.description = "Making calls for change! Complete 10 phone banking sessions."
      badge.icon = "phone"
      badge.color = "info"
      badge.category = "activism_type"
      badge.requirement_type = "post_type_count"
      badge.requirement_value = 10
      badge.active = true
    end

    Badge.find_or_create_by(name: "Rally Champion") do |badge|
      badge.description = "Show up and speak up! Attend 5 rallies or events."
      badge.icon = "bullhorn"
      badge.color = "danger"
      badge.category = "activism_type"
      badge.requirement_type = "post_type_count"
      badge.requirement_value = 5
      badge.active = true
    end

    Badge.find_or_create_by(name: "Democracy Defender") do |badge|
      badge.description = "Protecting voting rights! Complete 3 voter registration drives."
      badge.icon = "vote-yea"
      badge.color = "success"
      badge.category = "activism_type"
      badge.requirement_type = "post_type_count"
      badge.requirement_value = 3
      badge.active = true
    end

    Badge.find_or_create_by(name: "Volunteer Hero") do |badge|
      badge.description = "Giving your time! Complete 10 volunteer activities."
      badge.icon = "hands-helping"
      badge.color = "warning"
      badge.category = "activism_type"
      badge.requirement_type = "post_type_count"
      badge.requirement_value = 10
      badge.active = true
    end

    # Impact Badges
    Badge.find_or_create_by(name: "Rising Activist") do |badge|
      badge.description = "You're making an impact! Earn 50 activism points."
      badge.icon = "chart-line"
      badge.color = "success"
      badge.category = "impact"
      badge.requirement_type = "total_points"
      badge.requirement_value = 50
      badge.active = true
    end

    Badge.find_or_create_by(name: "Seasoned Organizer") do |badge|
      badge.description = "A true force for change! Earn 200 activism points."
      badge.icon = "medal"
      badge.color = "primary"
      badge.category = "impact"
      badge.requirement_type = "total_points"
      badge.requirement_value = 200
      badge.active = true
    end

    Badge.find_or_create_by(name: "Movement Leader") do |badge|
      badge.description = "Leading the revolution! Earn 500 activism points."
      badge.icon = "crown"
      badge.color = "warning"
      badge.category = "impact"
      badge.requirement_type = "total_points"
      badge.requirement_value = 500
      badge.active = true
    end

    # Consistency Badges
    Badge.find_or_create_by(name: "Consistent Contributor") do |badge|
      badge.description = "Staying engaged! Be active for 7 different days."
      badge.icon = "calendar-check"
      badge.color = "info"
      badge.category = "consistency"
      badge.requirement_type = "days_active"
      badge.requirement_value = 7
      badge.active = true
    end

    Badge.find_or_create_by(name: "Monthly Activist") do |badge|
      badge.description = "Making it a habit! Be active for 30 different days."
      badge.icon = "calendar"
      badge.color = "primary"
      badge.category = "consistency"
      badge.requirement_type = "days_active"
      badge.requirement_value = 30
      badge.active = true
    end

    # Social Badges
    Badge.find_or_create_by(name: "Well Liked") do |badge|
      badge.description = "Your message resonates! Receive 25 likes on your posts."
      badge.icon = "thumbs-up"
      badge.color = "danger"
      badge.category = "social"
      badge.requirement_type = "likes_received"
      badge.requirement_value = 25
      badge.active = true
    end

    Badge.find_or_create_by(name: "Inspirational") do |badge|
      badge.description = "You inspire others! Receive 100 likes on your posts."
      badge.icon = "heart"
      badge.color = "danger"
      badge.category = "social"
      badge.requirement_type = "likes_received"
      badge.requirement_value = 100
      badge.active = true
    end

    # Special Badges
    Badge.find_or_create_by(name: "Storyteller") do |badge|
      badge.description = "Documenting the movement! Share 25 posts about your activism."
      badge.icon = "book"
      badge.color = "secondary"
      badge.category = "special"
      badge.requirement_type = "total_posts"
      badge.requirement_value = 25
      badge.active = true
    end

    Badge.find_or_create_by(name: "Super Activist") do |badge|
      badge.description = "Going above and beyond! Share 50 posts about your activism."
      badge.icon = "rocket"
      badge.color = "warning"
      badge.category = "special"
      badge.requirement_type = "total_posts"
      badge.requirement_value = 50
      badge.active = true
    end

    puts "Created #{Badge.count} badges!"

    # Also run badge checks for existing users if any
    if User.any?
      puts "Checking badges for existing users..."
      User.find_each do |user|
        user.check_and_award_badges!
        user.check_and_record_achievements!
      end
      puts "Badge check complete!"
    end
  end
end