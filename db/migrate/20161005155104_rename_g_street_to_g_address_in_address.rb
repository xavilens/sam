class RenameGStreetToGAddressInAddress < ActiveRecord::Migration
  def change
    rename_column :addresses, :gstreet, :gaddress
  end
end
