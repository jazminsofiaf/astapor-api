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

    course.add_student
    @inscriptions << course.code

    true
  end

  def add_grade(grade)
    # si no esta inscripto deberia lanzar excepcion
    @grades[grade.code] = grade.grades
    # aca se lo debe desincribir al alumno
    @inscriptions.delete(grade.code)
  end

  # def is_inscribed_in(course_code)
  # new_student = StudentsRepository.new.load_object(obtain_record)
  # new_student.inscriptions.each do |code|
  # return true if course_code == code &&
  # end
  # false
  # end
end
