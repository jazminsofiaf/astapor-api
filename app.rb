# frozen_string_literal: true

require 'sinatra'
require 'sinatra/activerecord'
require './environments'

get '/welcome_message' do
  'Hola desde Guarani'
end
