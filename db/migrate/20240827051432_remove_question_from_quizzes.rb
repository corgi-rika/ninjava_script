class RemoveQuestionFromQuizzes < ActiveRecord::Migration[7.0]
  def change
    remove_column :quizzes, :question, :string
  end
end
