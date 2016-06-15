class CreateBandStatuses < ActiveRecord::Migration
  def change
    create_table :band_statuses do |t|
      t.string :name
    end
  end
end
