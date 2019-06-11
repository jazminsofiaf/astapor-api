require_relative '../models/course'
require_relative '../exceptions/duplicated_inscription'

class Student
  include ActiveModel::Validations
  attr_accessor :id, :name, :user_name, :inscriptions, :grades, :updated_on, :created_on

  def initialize(data)
    @id = data[:id]
    @name = data[:name]
    @user_name = data[:user_name]
    @inscriptions = data[:inscriptions] || []
    @grades = data[:grades] || {}
    @updated_on = data[:updated_on]
    @created_on = data[:created_on]
    validation
  end

  def validation
    raise StudentCreationError unless
      (@inscriptions.empty? && @grades.empty?) ||
      StudentsRepository.new.exist_already(@user_name)
  end

  def inscribe_to(course)
    raise DuplicatedInscription if @inscriptions.include?(course.code)

    course.reduce_quota
    @inscriptions << course.code

    true
  end

  def course_calification_with(code_course, grades)
    # aca se lo debe desincribir al alumno
    @grades[code_course] = grades
  end

  def is_inscripted_on(course_code)
    new_student = StudentsRepository.new.load_object(obtain_record)
    new_student.inscriptions.each do |code|
      return true if course_code == code
    end
    false
  end

  def obtain_record
    { id: @id, name: @name, user_name: @user_name,
      updated_on: @updated_on, created_on: @created_on }
  end
end
