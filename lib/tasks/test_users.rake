namespace :test_users do
  # be rake test_users:make_test_user --trace
  task :make_test_user => :environment do 
    open_struct = make_open_struct
    
    os_kayla = make_open_struct
    os_kayla.email = "kaylamcguire91@gmail.com"
    os_kayla.username = "kayla"
    os_kayla.first_name = "Kayla"
    os_kayla.last_name = "McGuire"
    os_kayla.password = "password123"
    os_kayla.password_confirmation = "password123"    
    status, user = User.find_or_create(os_kayla)
    
    os_taelar = make_open_struct
    os_taelar.email = "taelarchristman@gmail.com"
    os_taelar.username = "taelar"
    os_taelar.first_name = "Taelar"
    os_taelar.last_name = "Christman"
    os_taelar.password = "password123"
    os_taelar.password_confirmation = "password123"
    status, user = User.find_or_create(os_taelar)
    
    os_alex = make_open_struct
    os_alex.email = "alexjohnsonfishers@gmail.com"
    os_alex.username = "alex"
    os_alex.first_name = "Alex"
    os_alex.last_name = "Johnson"
    os_alex.password = "password123"
    os_alex.password_confirmation = "password123"
    status, user = User.find_or_create(os_alex)
    
  end
  
  def make_open_struct
    os = OpenStruct.new
    os.email = ""
    os.username = ""
    os.first_name = ""
    os.last_name = ""
    os.password = ""
    os.password_confirmation = ""
    
    os
  end
end