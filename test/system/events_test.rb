require "application_system_test_case"

class EventsTest < ApplicationSystemTestCase
  setup do
    @event = events(:one)
  end

  test "visiting the index" do
    visit events_url
    assert_selector "h1", text: "Events"
  end

  test "should create event" do
    visit events_url
    click_on "New event"

    fill_in "Address1", with: @event.address1
    fill_in "Address2", with: @event.address2
    fill_in "City", with: @event.city
    fill_in "Congressional district", with: @event.congressional_district_id
    fill_in "Event end at", with: @event.event_end_at
    fill_in "Event start at", with: @event.event_start_at
    fill_in "Event type", with: @event.event_type_id
    fill_in "Fid", with: @event.fid
    check "Is suggested event" if @event.is_suggested_event
    fill_in "Mobilize url", with: @event.mobilize_url
    fill_in "Name", with: @event.name
    fill_in "Organization fid", with: @event.organization_fid
    fill_in "Organization", with: @event.organization_id
    fill_in "Pasted description", with: @event.pasted_description
    fill_in "Recurrence", with: @event.recurrence
    check "Recurring" if @event.recurring
    fill_in "Slug", with: @event.slug
    fill_in "State", with: @event.state_id
    fill_in "Url", with: @event.url
    click_on "Create Event"

    assert_text "Event was successfully created"
    click_on "Back"
  end

  test "should update Event" do
    visit event_url(@event)
    click_on "Edit this event", match: :first

    fill_in "Address1", with: @event.address1
    fill_in "Address2", with: @event.address2
    fill_in "City", with: @event.city
    fill_in "Congressional district", with: @event.congressional_district_id
    fill_in "Event end at", with: @event.event_end_at.to_s
    fill_in "Event start at", with: @event.event_start_at.to_s
    fill_in "Event type", with: @event.event_type_id
    fill_in "Fid", with: @event.fid
    check "Is suggested event" if @event.is_suggested_event
    fill_in "Mobilize url", with: @event.mobilize_url
    fill_in "Name", with: @event.name
    fill_in "Organization fid", with: @event.organization_fid
    fill_in "Organization", with: @event.organization_id
    fill_in "Pasted description", with: @event.pasted_description
    fill_in "Recurrence", with: @event.recurrence
    check "Recurring" if @event.recurring
    fill_in "Slug", with: @event.slug
    fill_in "State", with: @event.state_id
    fill_in "Url", with: @event.url
    click_on "Update Event"

    assert_text "Event was successfully updated"
    click_on "Back"
  end

  test "should destroy Event" do
    visit event_url(@event)
    click_on "Destroy this event", match: :first

    assert_text "Event was successfully destroyed"
  end
end
