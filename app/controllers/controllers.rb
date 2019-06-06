# frozen_string_literal: true

AstaporGuarani::App.controllers do
  # method for testing walking skeleton
  get '/a' do
    course_param = { id: 2, code: 7515, subject: 'Analisis',
                     teacher: 'Sirne', quota: 50, modality: 'tp',
                     projector: false, laboratory: false }
    algebra = Course.new(course_param)
    CoursesRepository.new.save(algebra)
    course = CoursesRepository.new.search_by_subject('Algebra')
    content_type :json
    course.to_json
  end

  # method for create new course
  post :materias do
    push = JSON.parse(request.body.read)
    puts "I got some JSON: #{push.inspect}"
  end
end
