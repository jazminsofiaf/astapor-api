require_relative '../../exceptions/inscription_error'

AstaporGuarani::App.controllers do
  get '/' do
    course = CoursesRepository.new.search_by_subject('memo')
    content_type :json
    course.to_json
  end
end
