class ChangeLikesFkAllowNull < ActiveRecord::Migration[6.0]
  def change
    change_column_null  :likes, :comment_id, true
    change_column_null  :likes, :post_id, true
  end
end
