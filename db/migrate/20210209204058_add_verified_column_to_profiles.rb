class AddVerifiedColumnToProfiles < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :verified, :boolean
  end
end
