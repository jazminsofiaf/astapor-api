require_relative '../models/course'
# Student class
class Student
  include ActiveModel::Validations
  attr_accessor :id, :name, :user_name, :updated_on, :created_on

  def initialize(data)
    @id = data[:id]
    @name = data[:name]
    @user_name = data[:user_name]
    @inscriptions = []
    @grades = {}
    @updated_on = data[:updated_on]
    @created_on = data[:created_on]
  end

  def inscribe_to(course)
    raise DuplicatedInscription if @inscriptions.include?(course.id)

    @inscriptions << course.id
    course.reduce_quota
    true
  end
end
