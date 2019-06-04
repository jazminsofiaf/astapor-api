# frozen_string_literal: true

require_relative '../app/repositories/courses_repository'
require_relative '../models/course'

module AstaporGuarani
  # comment
  class App < Padrino::Application
    get '/welcome_message' do
      'Hola desde Guarani'
    end

    get '/' do
      course_param = { id: 1, code: 7514, subject: 'Algebra',
                       teacher: 'Sirne', quota: 50, modality: 'tp' }
      algebra = Course.new(course_param)
      CoursesRepository.new.save(algebra)
      course = CoursesRepository.new.search_by_subject('Algebra')
      content_type :json
      course.to_json
    end
  end
end
