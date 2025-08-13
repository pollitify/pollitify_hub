class SetupController < ApplicationController
  
  include Wicked::Wizard

  steps :your_organization, :your_domain, :your_features, :your_account
  
  def show
    @organization = Organization.new 
    @states = State.ordered_by_name
    @secure_chat_systems = SecureChatSystem.ordered_by_name
    @user = current_user
    case step
    when :your_organization
    when :your_domain
      @domains = Domain.all
    when :your_features
      @feature_categories = FeatureCategory.order("name ASC")
    when :review

    when :your_account
      
    end
    render_wizard
  end
  
end
