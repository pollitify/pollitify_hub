# Pollitify Launch Strategy

Pollitify is two components:

* A hub which lists events by locality and cookies each visitor so they only see the events relevant to them (this will be some kind of popup the first time they come to the site which asks them city / state)
* The Pollitify software aka the old Polly software which people use to develop their own events and is what we charge for

There are at least two launch strategies:

1. Strategy 1: Tooling First; Hub Second.  Get the tooling finished and go live by getting people to use the tools and have their events flow into the hub
2. Strategy 2: Hub First; Tooling Second.  Get the hub finished first and take it live and populate it using the suggest feature ourselves and then focus on getting people to use the tooling

A key problem with option 1 is that we're never JUST going to have our own events listed on Pollitify -- there are too many other events out there **everywhere**.  We need to list as many events as possible in the way that Calendar Club used to list everything and that brings us to the Suggest feature.

## Sidebar: The Suggest Feature

At the very end of Polly, I was asked to implement a Suggest feature which could add events more easily and I did even though it never got deployed.  I started looking at resurrecting the Suggest feature today and realized it can be implemented in 4 ways:

* A form people fill out (boo -- boring; hard; who likes web forms; icky poo)
* A text parser where people paste in a description and it auto extracts name / location / date / time (useful but would require data review)
* A mobilize parser where a mobilize url is given to us and we grab the data for the event and add it to us (90% implemented already)
* A flier parser where people upload fliers to us and we read them via OCR and automatically insert the events in our db

I built the equivalent of a flier parser about a decade ago using vastly more primitive tools and I can likely do it again relatively easily.

The flier parser makes me think that we need to consider our launch strategy more carefully as this could potentially give us thousands of events across the nation if we data mine mildly aggressively.

## Strategy 1: Tooling First; Hub Second

With strategy 1, we don't worry so much about the hub, we finish the current work on the hub by mid next week, do the new hosting and then go back to working on the tooling.  If we go this route, we need to pick exactly the features we want to launch with initially and make them **solid**.  My advice would be to focus solely on the event builder.  And then launch a new feature roughly every week or two based on complexity.  

With this approach events would be populating into the hub as they are created but data population is going to be slow because people have to learn and adopt a new tool for building events.  We had a fast adoption rate because we were creating the tool and I was forcing its use.  Without that it is going to be a process of releasing software, creating demos, videos, advocating for use, etc.  Save a large organization like Indivisible endorsing us to its members it may be hard.

## Strategy 2: Hub First; Tooling Second

With strategy 2, we spend a bunch of time on the Suggest feature and aggressively load events from other states i.e. goto /r/ohio and look for fliers for events and such and load them ourselves and try to get to critical mass.  We may even want to recruit state level ambassadors for Pollitify aka the way the Calendar Club operated.

We take the hub live and start to promote it and then focus on getting users for the software.  A similar approach of picking the features and launching them as they are solid applies.

## Strategy 3: Everything All At Once

The final strategy is try and get everything done and launch together.  There are likely pros and cons to this as well.  I'm more concerned about this now than I'v e been because in my head there were always two engineers (and, yes, Aric wasn't much but he was something).

## Sidebar: Maybe Add Some Mobilize Features We Don't Currently Have

I think we need to get an understanding of Mobilize and what it does.  My understanding is event listing and event notification are its key features.  Notification isn't hard and we could add that (even though it costs us something to send emails / texts) and control it so we don't break the bank.  That could be done with strategy 2 and would have the benefit of driving engagement and recurring site returns.

## Concerns

The more I think about it, the more I realize that we need to represent events not built with our tooling.  That's the only way that Pollitify is comparable to Mobilize.  And I think that the Suggest feature can pretty easily give us that.  But investing another couple of weeks engineering (or even a single week) in a single feature potentially changes our launch plan hence this document.