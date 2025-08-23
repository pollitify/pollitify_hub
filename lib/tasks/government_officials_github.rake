# #last_name,first_name,middle_name,suffix,nickname,full_name,birthday,gender,type,state,district,senate_class,party,url,address,phone,contact_form,rss_url,twitter,twitter_id,facebook,youtube,youtube_id,mastodon,bioguide_id,thomas_id,opensecrets_id,lis_id,fec_ids,cspan_id,govtrack_id,votesmart_id,ballotpedia_id,washington_post_id,icpsr_id,wikipedia_id
#
#
# namespace :government_officials_github do
#
#   #rails g scaffold Organization name:string city:string state:string location:string organization_type:string
#
#   # be rake government_officials_github:init --trace
#   task :init => :environment do
#     Rake::Task["government_officials_github:seed"].invoke
#     Rake::Task["government_officials_github:metrics"].invoke
#   end
#
#   # be rake government_officials_github:set_data_source --trace
#   task :set_data_source => :environment do
#     gos = GovernmentOfficial.all
#     gos.each do |go|
#       go.data_source = "github_master_data.csv"
#       go.save
#     end
#   end
#
#   # be rake government_officials_github:rename_existing_with_a_z --trace
#   task :rename_existing_with_a_z => :environment do
#     government_officials = GovernmentOfficial.all
#     government_officials.each do |go|
#       go.update_column(:full_name, "#{go.full_name}__z")
#     end
#   end
#
#   # be rake government_officials_github:seed
#   task :seed => :environment do
#
#     # moved to government_officials.rake
#     # if you need the old code then look at git history for this file BEFORE 8/22 evening around 8 pm
#
#     end
#
#   end
#
#   # be rake government_officials_github:metrics
#   task :metrics => :environment do
#     klass = "GovernmentOfficial"
#     puts "For object: #{klass.to_s}, there are #{klass.constantize.count} objects in the database"
#   end
#
# end