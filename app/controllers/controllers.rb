require_relative '../../exceptions/course_not_found_error'
require_relative '../../exceptions/astapor_error'
require_relative '../../exceptions/incompatible_request_exception'

AstaporGuarani::App.controllers do
  # walking skeleton
  get '/' do
    course = CoursesRepository.new.search_by_subject('memo')
    content_type :json
    course.to_json
  end

  post '/reset' do
    CoursesRepository.new.delete_all
  end

  post '/materias' do
    course = CourseHelper.parse(request.body.read)
    unless course.valid?
      status 400
      return { 'resultado': course.errors.messages.values.flatten[0],
               'error': course.errors.messages.values.flatten[0] }.to_json
    end
    CoursesRepository.new.save(course)
    status 201
    { 'resultado': 'materia_creada' }.to_json
  end

  post '/alumnos' do
    inscription_request = InscriptionHelper.new(JSON.parse(request.body.read))
    student_params = { name: inscription_request.complete_name,
                       user_name: inscription_request.username }
    student = StudentsRepository.new.find_or_create(student_params)
    course = CoursesRepository.new.find_by_code(inscription_request.code)
    raise CourseNotFoundError if course.nil?

    student.inscribe_to(course)
    status 200
    { 'resultado': 'inscripcion_creada' }.to_json
  end

  error IncompatibleRequestException do |error|
    status 400
    { 'resultado': spanish_error_msg(error) }.to_json
  end

  error AstaporError do |error|
    status 400
    { 'error': spanish_error_msg(error).upcase }.to_json
  end
end
