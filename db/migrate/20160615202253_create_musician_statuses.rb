class CreateMusicianStatuses < ActiveRecord::Migration
  def change
    create_table :musician_statuses do |t|
      t.string :name
    end
  end
end
