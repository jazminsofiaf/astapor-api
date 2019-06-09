require_relative '../app/repositories/courses_repository'
require_relative '../models/course'
require_relative '../exceptions/astapor_error'
module AstaporGuarani
  # comment
  class App < Padrino::Application
    set :show_exceptions, false
    register Padrino::Rendering
    register Padrino::Helpers

    get '/welcome_message' do
      course = CoursesRepository.new.search_by_subject('Algebra')[0]
      'Welcome to ' + course.code.to_s
    end

    post '/alumnos' do
      inscription_request = ParseInscriptionJson.new(JSON.parse(request.body.read))
      student_params = { name: inscription_request.complete_name,
                         user_name: inscription_request.username }
      student = StudentsRepository.new.find_or_create(student_params)
      course = CoursesRepository.new.find_by_code(inscription_request.code)
      raise InscriptionError if course.nil?

      student.inscribe_to(course)
      status 200
    end

    error AstaporError do |error|
      status 400
      { 'error': error.msg }.to_json
    end
  end
end
