# frozen_string_literal: true

AstaporGuarani::App.controllers do
  get '/' do
    course = CoursesRepository.new.search_by_subject('Algebra')
    content_type :json
    course.to_json
  end

  post :create_course do
    course_param = { id: 2, code: 7515, subject: 'Analisis',
                     teacher: 'Sirne', quota: 50, modality: 'tp',
                     laboratory: 'si', projector: 'no' }
    algebra = Course.new(course_param)
    CoursesRepository.new.save(algebra)
  end
end
