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
  post '/materias' do
    course = CourseFromJson.parse(request.body.read)
    CoursesRepository.new.save(course)
    status 201
    { "resultado": 'materia_creada' }.to_json
  end

  error IncompatibleRequestException do
    status 400
    { "resultado": 'pedidos_incompatibles' }.to_json
  end

  error ErroneousCode do
    status 400
    { 'resultado': 'CODIGO_ERRONEO' }.to_json
  end

  error DuplicateSubjectException do
    status 400
    { 'error': 'MATERIA_DUPLICADA' }.to_json
  end

  post '/reset' do
    CoursesRepository.new.delete_all
  end
end
