# == Schema Information
#
# Table name: todo_lists
#
#  id         :integer          not null, primary key
#  project_id :integer          not null
#  author_id  :integer          not null
#  title      :string           not null
#  body       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TodoList < ActiveRecord::Base

  attr_accessor :list_of_todos

  belongs_to(
    :project,
    class_name: "Project",
    foreign_key: :project_id
  )

  has_many(
    :todos,
    class_name: "Todo",
    foreign_key: :todo_list_id
  )
end
