require_relative '../models/course'

course_repository = CoursesRepository.new
unless course_repository.all.count.positive?
  memo_params = { code: 9530, subject: 'Memo',
                  teacher: 'Villagra', quota: 50, modality: 'tp' }
  memo = Course.new(memo_params)

  memo2_params = { code: 9532, subject: 'Memo2',
                   teacher: 'Nico Paez', quota: 33, modality: 'tp' }
  memo2 = Course.new(memo2_params)

  course_repository.save memo
  course_repository.save memo2
end
