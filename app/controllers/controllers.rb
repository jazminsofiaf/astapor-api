# frozen_string_literal: true

AstaporGuarani::App.controllers do
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
