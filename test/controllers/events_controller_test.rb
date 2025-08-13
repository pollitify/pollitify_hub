require "test_helper"

class EventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event = events(:one)
  end

  test "should get index" do
    get events_url
    assert_response :success
  end

  test "should get new" do
    get new_event_url
    assert_response :success
  end

  test "should create event" do
    assert_difference("Event.count") do
      post events_url, params: { event: { address1: @event.address1, address2: @event.address2, city: @event.city, congressional_district_id: @event.congressional_district_id, event_end_at: @event.event_end_at, event_start_at: @event.event_start_at, event_type_id: @event.event_type_id, fid: @event.fid, is_suggested_event: @event.is_suggested_event, mobilize_url: @event.mobilize_url, name: @event.name, organization_fid: @event.organization_fid, organization_id: @event.organization_id, pasted_description: @event.pasted_description, recurrence: @event.recurrence, recurring: @event.recurring, slug: @event.slug, state_id: @event.state_id, url: @event.url } }
    end

    assert_redirected_to event_url(Event.last)
  end

  test "should show event" do
    get event_url(@event)
    assert_response :success
  end

  test "should get edit" do
    get edit_event_url(@event)
    assert_response :success
  end

  test "should update event" do
    patch event_url(@event), params: { event: { address1: @event.address1, address2: @event.address2, city: @event.city, congressional_district_id: @event.congressional_district_id, event_end_at: @event.event_end_at, event_start_at: @event.event_start_at, event_type_id: @event.event_type_id, fid: @event.fid, is_suggested_event: @event.is_suggested_event, mobilize_url: @event.mobilize_url, name: @event.name, organization_fid: @event.organization_fid, organization_id: @event.organization_id, pasted_description: @event.pasted_description, recurrence: @event.recurrence, recurring: @event.recurring, slug: @event.slug, state_id: @event.state_id, url: @event.url } }
    assert_redirected_to event_url(@event)
  end

  test "should destroy event" do
    assert_difference("Event.count", -1) do
      delete event_url(@event)
    end

    assert_redirected_to events_url
  end
end
