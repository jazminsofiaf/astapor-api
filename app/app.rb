module AstaporGuarani
  class App < Padrino::Application

    get '/welcome_message' do
      'Hola desde Guarani'
    end

    get '/' do
      course = CoursesRepository.new.search_by_subject('Algebra')
      content_type :json
      course.to_json
    end
  end
end


