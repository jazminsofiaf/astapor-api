# frozen_string_literal: true

require_relative '../models/course'
# Student class
class Student
  attr_accessor :id, :name, :user_name

  def initialize(id, name, user_name)
    @id = id
    @name = name
    @user_name = user_name
    @inscriptions = {}
  end

  def inscribe_to(course)
    raise DuplicatedInscription if @inscriptions.key?(course.id)

    @inscriptions[course.id] = 'aca objeto con notas, cuatrimestre etc'
    true
  end
end
