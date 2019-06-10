require_relative '../../models/courses_offers_parser'

AstaporGuarani::App.controllers do
  # method for testing walking skeleton
  set :show_exceptions, false
  get '/a' do
    analisis = Course.new(id: 2, code: 7557, subject: 'Analisis',
                          teacher: 'Sirne', quota: 50, modality: 'tp',
                          projector: false, laboratory: false)
    CoursesRepository.new.save(analisis)
    course = CoursesRepository.new.search_by_subject('Analisis')
    content_type :json
    course.to_json
  end

  get '/materias' do
    courses = CoursesRepository.new.load_dataset
    courses_response = CoursesOffersParser.new.parse(courses)
    { 'oferta': courses_response }.to_json
  end
end
