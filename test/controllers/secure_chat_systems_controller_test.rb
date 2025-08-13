require "test_helper"

class SecureChatSystemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @secure_chat_system = FactoryBot.create(:secure_chat_system)
    @user = FactoryBot.create(:user)
    #@secure_chat_system_category = FactoryBot.create(:feature_category, fid: "dddd")
  end
  
  test "should get index if not logged in" do
    get secure_chat_systems_url
    assert_response :redirect
  end
  
  test "should get index if logged in" do
    sign_in @user
    get secure_chat_systems_url
    assert_response :success
  end
  
  
  
  test "should get new if not logged in" do
    get new_secure_chat_system_url
    assert_response :redirect
  end

  test "should get new if logged in" do
    sign_in @user
    get new_secure_chat_system_url
    assert_response :success
  end



  test "should NOT create feature_category if not logged in" do
    assert_no_difference("SecureChatSystem.count") do
      post secure_chat_systems_url, params: { secure_chat_system: { description: @secure_chat_system.description, fid: @secure_chat_system.fid, icon_url: @secure_chat_system.icon_url, name: @secure_chat_system.name, url: @secure_chat_system.url } }
    end

    assert_response :redirect
  end

  test "should create feature_category if logged in" do
    sign_in @user
    assert_difference("SecureChatSystem.count", 1) do
      post secure_chat_systems_url, params: { secure_chat_system: { description: @secure_chat_system.description, fid: "dfdfd", icon_url: @secure_chat_system.icon_url, name: "fdfdfd", url: @secure_chat_system.url } }
    end

    assert_redirected_to secure_chat_system_url(SecureChatSystem.last)
  end



  test "should NOT show feature_category if NOT logged in" do
    get secure_chat_system_url(@secure_chat_system)
    assert_response :redirect
  end

  test "should show feature_category if logged in" do
    sign_in @user
    get secure_chat_system_url(@secure_chat_system)
    assert_response :success
  end



  test "should get edit if NOT logged in" do
    get edit_secure_chat_system_url(@secure_chat_system)
    assert_response :redirect
  end

  test "should get edit if logged in" do
    sign_in @user
    get edit_secure_chat_system_url(@secure_chat_system)
    assert_response :success
  end



  test "should update domain if not logged in" do
    patch secure_chat_system_url(@secure_chat_system), params: { secure_chat_system: { description: @secure_chat_system.description, fid: @secure_chat_system.fid, icon_url: @secure_chat_system.icon_url, name: @secure_chat_system.name, url: @secure_chat_system.url } }
    assert_response :redirect
  end

  test "should update domain if logged in" do
    sign_in @user
    patch secure_chat_system_url(@secure_chat_system), params: { secure_chat_system: { description: @secure_chat_system.description, fid: @secure_chat_system.fid, icon_url: @secure_chat_system.icon_url, name: @secure_chat_system.name, url: @secure_chat_system.url } }
    assert_redirected_to secure_chat_system_url(@secure_chat_system)
  end



  test "should NOT destroy feature_category if not logged in" do
    assert_difference("SecureChatSystem.count", 0) do
      delete secure_chat_system_url(@secure_chat_system)
    end

    assert_response :redirect
  end
  
  test "should destroy feature_category if logged in" do
    sign_in @user
    assert_difference("SecureChatSystem.count", -1) do
      delete secure_chat_system_url(@secure_chat_system)
    end

    assert_redirected_to secure_chat_systems_url
  end
  
  
  # setup do
  #   @secure_chat_system = secure_chat_systems(:one)
  # end
  #
  # test "should get index" do
  #   get secure_chat_systems_url
  #   assert_response :success
  # end
  #
  # test "should get new" do
  #   get new_secure_chat_system_url
  #   assert_response :success
  # end
  #
  # test "should create secure_chat_system" do
  #   assert_difference("SecureChatSystem.count") do
  #     post secure_chat_systems_url, params: { secure_chat_system: { description: @secure_chat_system.description, fid: @secure_chat_system.fid, icon_url: @secure_chat_system.icon_url, name: @secure_chat_system.name, url: @secure_chat_system.url } }
  #   end
  #
  #   assert_redirected_to secure_chat_system_url(SecureChatSystem.last)
  # end
  #
  # test "should show secure_chat_system" do
  #   get secure_chat_system_url(@secure_chat_system)
  #   assert_response :success
  # end
  #
  # test "should get edit" do
  #   get edit_secure_chat_system_url(@secure_chat_system)
  #   assert_response :success
  # end
  #
  # test "should update secure_chat_system" do
  #   patch secure_chat_system_url(@secure_chat_system), params: { secure_chat_system: { description: @secure_chat_system.description, fid: @secure_chat_system.fid, icon_url: @secure_chat_system.icon_url, name: @secure_chat_system.name, url: @secure_chat_system.url } }
  #   assert_redirected_to secure_chat_system_url(@secure_chat_system)
  # end
  #
  # test "should destroy secure_chat_system" do
  #   assert_difference("SecureChatSystem.count", -1) do
  #     delete secure_chat_system_url(@secure_chat_system)
  #   end
  #
  #   assert_redirected_to secure_chat_systems_url
  # end
end
