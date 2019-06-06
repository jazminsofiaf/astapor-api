# frozen_string_literal: true

# Student class
class Student
  attr_accessor :id, :name, :user_name

  def initialize(_id, _name, _user_name)
    self.id = @id
    self.name = @name
    self.user_name = @user_name
  end

  def inscribe_to(_course)
    true
  end
end
