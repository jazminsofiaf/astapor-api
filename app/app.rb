module AstaporGuarani
  class App < Padrino::Application
    set :show_exceptions, false
    register Padrino::Rendering
    register Padrino::Helpers

    get '/welcome_message' do
      'Hola desde Guarani'
    end
  end
end
