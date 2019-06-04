# frozen_string_literal: true

require 'sinatra'

get '/welcome_message' do
  'Hola desde Guarani'
end

get '/' do
  course = CoursesRepository.new.search_by_subject('Algebra')
  content_type :json
  course.to_json
end
