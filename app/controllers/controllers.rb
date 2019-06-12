require_relative '../../app/helpers/error/astapor_error'
require_relative '../../app/helpers/error/exception/astapor_exception'

AstaporGuarani::App.controllers do
  # walking skeleton
  get '/' do
    course = CoursesRepository.new.search_by_subject('memo')
    content_type :json
    course.to_json
  end

  get '/materias' do
    courses = CoursesRepository.new.load_dataset
    courses_response = CoursesOffersParser.new.parse(courses)
    status 200
    { 'oferta': courses_response }.to_json
  end

  post '/reset' do
    CoursesRepository.new.delete_all
    StudentsRepository.new.delete_all
    RegisterRepository.new.delete_all
  end

  post '/materias' do
    course = CourseHelper.parse(request.body.read)
    raise DuplicateSubjectError if CoursesRepository.new.find_by_code(course.code)

    CoursesRepository.new.save(course)
    status 201
    { 'resultado': 'materia_creada' }.to_json
  end

  post '/calificar' do
    grade = GradeHelper.new(JSON.parse(request.body.read))
    student = StudentsRepository.new.find_by_user_name(grade.username)
    # raise StudentNotInscriptedError if student.nil? || student.is_inscribed_in(calification.code)

    student.add_grade(grade)
    StudentsRepository.new.save(student)
    status 200
    { 'resultado': 'notas_creadas' }.to_json
  end

  get '/materias/estado' do
    student_name = params['usernameAlumno']
    subject_code = params['codigoMateria']

    student = StudentsRepository.new.find_by_user_name(student_name)

    unless student.is_inscribed_in(subject_code)
      return { 'estado': params['usernameAlumno'],
               'nota_final': params['codigoMateria'] }.to_json
    end
  end

  post '/alumnos' do
    inscription_request = InscriptionHelper.new(JSON.parse(request.body.read))
    student_params = { name: inscription_request.complete_name,
                       user_name: inscription_request.username }
    student = StudentsRepository.new.find_or_create(student_params)
    course = CoursesRepository.new.find_by_code(inscription_request.code)
    raise CourseNotFoundError if course.nil?

    student.inscribe_to(course)
    StudentsRepository.new.save(student)
    CoursesRepository.new.save(course)
    status 201
    { 'resultado': 'inscripcion_creada' }.to_json
  end

  error AstaporException do |exception|
    handle_exception(exception)
  end

  error AstaporError do |error|
    handle_error(error)
  end
end
