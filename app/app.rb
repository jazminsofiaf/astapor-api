# frozen_string_literal: true

require_relative '../app/repositories/courses_repository'
require_relative '../models/course'

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
