class AddCommentToReports < ActiveRecord::Migration[7.0]
  def change
    add_column :reports, :comment, :text
  end
end
