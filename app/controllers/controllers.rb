# frozen_string_literal: true

AstaporGuarani::App.controllers do
  # method for testing walking skeleton
  get '/a' do
    analisis = Course.new(id: 2, code: 7557, subject: 'Analisis',
                          teacher: 'Sirne', quota: 50, modality: 'tp',
                          projector: false, laboratory: false)
    CoursesRepository.new.save(analisis)
    course = CoursesRepository.new.search_by_subject('Analisis')
    content_type :json
    course.to_json
  end

  # method for create new course
  post :materias do
    push = JSON.parse(request.body.read)
    puts "I got some JSON: #{push.inspect}"
  end
end
