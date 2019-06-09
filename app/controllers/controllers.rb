require_relative '../../exceptions/inscription_error'

AstaporGuarani::App.controllers do
  get '/' do
    course = CoursesRepository.new.search_by_subject('memo')
    content_type :json
    course.to_json
  end

  post '/alumnos' do
    inscription_request = ParseInscriptionJson.new(JSON.parse(request.body.read))
    student_params = { name: inscription_request.complete_name,
                       user_name: inscription_request.username }
    student = StudentsRepository.new.find_or_create(student_params)
    course = CoursesRepository.new.find_by_code(inscription_request.code)
    raise InscriptionError if course.nil?

    student.inscribe_to(course)
    status 200
  end

  error AstaporError do |error|
    status 400
    { 'error': spanish_error_msg(error).upcase }.to_json
  end
end
