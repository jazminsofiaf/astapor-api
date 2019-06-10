# class thar reepresents a parser that works with courses

class CoursesOffersParser
  def parse(courses)
    info_courses = []
    courses.each do |course|
      info_courses.push('nombre': course.subject, 'codigo': course.code,
                        'docente': course.teacher, 'cupo': course.quota)
    end
    info_courses
  end
end
