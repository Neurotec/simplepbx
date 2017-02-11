class AddDomainToEndpoint < ActiveRecord::Migration[5.0]
  def change
    add_column :endpoints, :domain, :string
  end
end
