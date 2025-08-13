# Acceptance Criteria for Pollitify Hub

## 1. Prompt User for City, State and Cookie It

When a new user comes to the site they need to be prompted for a city and state pairing.  This will be automatically analyzed from their IP address but that's always at least a bit inaccurate (example for my IP address it came up with Florida).

status: DONE

## 2. Automatically Display Events Close to them By City, State

The city / state will automatically be searched for close events in the temporal future.

Initially this will be straight city / state searches but I have loaded lat / long coordinates of all cities > 20,000 and if we can establish their coordinates via some kind of look up table dynamically then we can look for events by a geographic search.

Note: This is likely all cities in the U.S. because it has cities as small as 0 people and the sum of people is about right for the whole U.S.:

rails8-authentication(dev)> City.count
  City Count (3.3ms)  SELECT COUNT(*) FROM "cities" /*application='Rails8Authentication'*/
20940
rails8-authentication(dev)> City.sum(:population)
  City Sum (13.1ms)  SELECT SUM("cities"."population") FROM "cities" /*application='Rails8Authentication'*/
372145191

Status: Cities, States loaded.  Automatic search still being implemented; need local data set to be loaded first (Monday goal.)

## 3. Allow Events to be End User Suggested

We want people to be able to promote their event quickly and easily by:

* Form Entry
* Mobilize Url import
* Paste in of Event Description
* Form Flier Upload (hardest)
* Google Sheet Upload (hardest)

Status: In progress; all features have UI completed; paste in has the code and algorithm completed; mobilize url has code and algorithm completed; flier upload is hardest

## 4. Allow them to Search by Other Criteria 

We want to allow them to easily search for events by other criteria if they don't like what they see by default.  This is likely three fields:

* Name / Description
* City
* State

Status: Not yet started; but done in the past and fully documented: https://fuzzyblog.io/blog/rails/2022/05/31/using-meilisearch-in-a-production-rails-environment.html

## 5. Allow them to Create an Account for Other Features

As an optional benefit to drive usage, we could include some level of feature for creating an account like group messaging via email or text if you create an account.  This would cost us $$$ for bulk sending fees but would likely get us user accounts.

Status: Really not yet thought about much.