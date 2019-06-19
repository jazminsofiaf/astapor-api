require_relative '../../app/helpers/error/astapor_error'
require_relative '../../models/grades_calculator'

AstaporGuarani::App.controllers do
  # walking skeleton
  get '/' do
    course = CoursesRepository.new.search_by_subject('memo')
    content_type :json
    course.to_json
  end

  get '/materias' do
    courses = CoursesRepository.new.load_dataset
    grades_calculator = GradePointAverage.new(ParamsHelper.user_name(params))
    passed_courses = grades_calculator.passed_courses_final_grades[0]
    courses = courses.reject do |course|
      passed_courses.include?(course.code)
    end
    courses_response = CoursesOffersParser.new.parse(courses)

    status 200
    { oferta: courses_response }.to_json
  end

  get '/alumnos/promedio' do
    status 200
    GradePointAverage.new(ParamsHelper.user_name(params)).calculate.to_json
  end

  get '/inscripciones' do
    student = StudentsRepository.new.find_by_user_name(ParamsHelper.user_name(params))
    codes = student.nil? ? [] : student.inscriptions
    courses = codes.map do |code|
      CoursesRepository.new.find_by_code(code)
    end
    courses_response = CoursesOffersParser.new.parse(courses)
    status 200
    { inscripciones: courses_response }.to_json
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
    { resultado: 'MATERIA_CREADA' }.to_json
  end

  post '/calificar' do
    grade = GradeHelper.new(JSON.parse(request.body.read))
    student = StudentsRepository.new.find_by_user_name(grade.username)
    raise StudentNotEnrolledError if student.nil?

    student.add_grade(grade)
    StudentsRepository.new.save(student)
    status 200
    { resultado: 'notas_creadas' }.to_json
  end

  get '/materias/estado' do
    user_name, subject_code = ParamsHelper.status_parse(params)
    student = StudentsRepository.new.find_or_create(user_name: user_name)
    course = CoursesRepository.new.find_by_code(subject_code)
    raise CourseNotFoundError if course.nil?

    final_results = GradesCalculator.new(student, course).calculate_final_grade
    final_results.to_json
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
    { resultado: 'INSCRIPCION_CREADA' }.to_json
  end

  error AstaporError do |error|
    handle_error(error)
  end
end
