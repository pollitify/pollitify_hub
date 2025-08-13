class ChangeYourDomainOrOurs < ActiveRecord::Migration[8.0]
  def change
    remove_column :organizations, :your_domain_or_ours
    add_column :organizations, :use_pollitify_base_domain, :boolean
  end
end
