require "application_system_test_case"

class SecureChatSystemsTest < ApplicationSystemTestCase
  setup do
    @secure_chat_system = secure_chat_systems(:one)
  end

  test "visiting the index" do
    visit secure_chat_systems_url
    assert_selector "h1", text: "Secure chat systems"
  end

  test "should create secure chat system" do
    visit secure_chat_systems_url
    click_on "New secure chat system"

    fill_in "Description", with: @secure_chat_system.description
    fill_in "Fid", with: @secure_chat_system.fid
    fill_in "Icon url", with: @secure_chat_system.icon_url
    fill_in "Name", with: @secure_chat_system.name
    fill_in "Url", with: @secure_chat_system.url
    click_on "Create Secure chat system"

    assert_text "Secure chat system was successfully created"
    click_on "Back"
  end

  test "should update Secure chat system" do
    visit secure_chat_system_url(@secure_chat_system)
    click_on "Edit this secure chat system", match: :first

    fill_in "Description", with: @secure_chat_system.description
    fill_in "Fid", with: @secure_chat_system.fid
    fill_in "Icon url", with: @secure_chat_system.icon_url
    fill_in "Name", with: @secure_chat_system.name
    fill_in "Url", with: @secure_chat_system.url
    click_on "Update Secure chat system"

    assert_text "Secure chat system was successfully updated"
    click_on "Back"
  end

  test "should destroy Secure chat system" do
    visit secure_chat_system_url(@secure_chat_system)
    click_on "Destroy this secure chat system", match: :first

    assert_text "Secure chat system was successfully destroyed"
  end
end
