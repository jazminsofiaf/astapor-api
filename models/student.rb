require_relative '../models/course'

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
    raise DuplicatedInscriptionError if @inscriptions.include?(course.code)

    course.reduce_quota
    @inscriptions << course.code

    true
  end

  def calificate(calification)
    # aca se lo debe desincribir al alumno
    @grades[calification.code] = calification.grades
    @grades[calification.code].each do |grade|
      reg = Register.new(code: calification.code, grade: grade,
                         student_username: calification.username)
      StudentsRepository.new.save_register(reg)
    end
  end

  # def is_inscribed_in(course_code)
  # new_student = StudentsRepository.new.load_object(obtain_record)
  # new_student.inscriptions.each do |code|
  # return true if course_code == code &&
  # end
  # false
  # end

  def obtain_record
    { id: @id, name: @name, user_name: @user_name,
      updated_on: @updated_on, created_on: @created_on }
  end
end
