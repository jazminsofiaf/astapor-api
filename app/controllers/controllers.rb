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

  # method for create new course
  post '/materias' do
    course = CourseFromJson.parse(request.body.read)
    CoursesRepository.new.save(course)
    status 201
    { "resultado": 'materia_creada' }.to_json
  rescue AstaporError => e
    status 400
    case e
    when DuplicateSubjectException
      { 'error': 'MATERIA_DUPLICADA' }.to_json
    when IncompatibleRequestException
      { "resultado": 'pedidos_incompatibles' }.to_json
    when ErroneousCode
      { 'resultado': 'CODIGO_ERRONEO' }.to_json
    end
  end

  error Sinatra::NotFound do
    content_type 'text/plain'
    [404, 'todavia no implementado']
  end

  post '/reset' do
    CoursesRepository.new.delete_all
  end
end
