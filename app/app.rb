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
  end
end
