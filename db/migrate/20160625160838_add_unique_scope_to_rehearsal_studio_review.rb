class AddUniqueScopeToRehearsalStudioReview < ActiveRecord::Migration
  def change
    change_column :rehearsal_studio_reviews, :rehearsal_studio_id, :integer, unique: {scope: :user_id}
  end
end
