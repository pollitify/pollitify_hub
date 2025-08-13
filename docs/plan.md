# Plan for politify_hub

The pollitify hub has four purposes:

1. It lists all events in the system as polled by pollitify_hub (or pushed to pollitify hub by an instance)
2. It captures a per user cookie which tells us what locality the user wants to see events in 
3. It is an admin tool which allows to configure an organization, their domain, their etc.
4. It then creates the polly instance with the first user
5. It is a billing center

Data Tables

* events
* organization
* domains
* features
* feature_categories

It is also a repository for "system" level information that is populated to every other end user Polly instance such as:

* states
* cities
* government officials