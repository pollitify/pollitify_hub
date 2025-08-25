module NavHelper
  NAVS = [
  ]
  NAVS << { path: "root_path", name: "Home" }
  NAVS << { path: "government_officials_path", name: "My Government" }
  NAVS << { path: "events_path", name: "Events" }
  NAVS << { path: "news_feed_items_path", name: "News" }
  NAVS << { path: "news_feed_items_path", name: "Candidates" } if 3 == 4
  NAVS << { path: "posts_path", name: "Feed" }
  NAVS << { path: "users_path", name: "Discover" }
  NAVS << { path: "badges_path", name: "Badges" }
  NAVS << { path: "new_post_path", name: "New Post" }
  NAVS << { path: "setup_index_path", name: "Setup" } if 3 == 4#if current_user && current_user.is_admin?
  #   ,
  #   ,
  #
  #   # ,
  #   # { path: "faqs_path", name: "FAQs" },
  #   # { path: "about_path", name: "About" },
  #   # { path: "contact_path", name: "Contact" }
  # ]
end
