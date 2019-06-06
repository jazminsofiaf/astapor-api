# frozen_string_literal: true

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
      begin
        course = CourseFromJson.parse(request.body.read)
      rescue IncompatibleRequestException
        status 400
        { 'si,': '', 'no,': 'pedidos_incompatibles' }.to_json
      end

      begin
        CoursesRepository.new.save(course)
      rescue DuplicateSubjectException
        status 400
        { 'error': 'MATERIA_DUPLICADA' }.to_json
      end
    end

    post '/reset' do
      CoursesRepository.new.delete_all
    end
  end
end
