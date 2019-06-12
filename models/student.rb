require_relative '../models/course'

CODE = 'codigo'.freeze

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

  def add_grade(grade)
    raise StudentNotInscribedError unless @inscriptions.include? grade.code

    @grades[grade.code] = grade.grades
    @inscriptions.delete(grade.code)
  end

  def filter_courses_by_no_approved(courses)
    courses_filtered = []
    courses.each do |course|
      next if grades.key?(course[:codigo])

      courses_filtered.push(course)
    end
    courses_filtered
  end
end
