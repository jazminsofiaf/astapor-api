require_relative '../app/repositories/courses_repository'
require_relative '../models/course'
require_relative '../app/exceptions/incompatible_request_exception'
require_relative '../app/exceptions/duplicate_subject_exception'
require 'byebug'

module AstaporGuarani
  # comment
  class App < Padrino::Application
    register Padrino::Rendering
    register Padrino::Helpers

    get '/welcome_message' do
      'Hola desde Guarani'
    end

    post '/materias' do
      course = CourseFromJson.parse(request.body.read)

      raise AstaporError unless course.valid?

      CoursesRepository.new.save(course)

    rescue IncompatibleRequestException
      status 400
      { "resultado": 'pedidos_incompatibles' }.to_json
    rescue DuplicateSubjectException
      status 400
      { "error": 'MATERIA_DUPLICADA' }.to_json
    rescue AstaporError
      status 400
      { "error": course.errors.messages.values.flatten[0],
        "resultado": course.errors.messages.values.flatten[0] }.to_json
    else
      status 201
      { "resultado": 'materia_creada' }.to_json
    end

    post '/reset' do
      CoursesRepository.new.delete_all
    end
  end
end
