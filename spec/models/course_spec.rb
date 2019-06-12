require_relative '../../models/course'
require_relative '../../models/student'

describe Course do
  describe 'model' do
    it { is_expected.to respond_to(:code) }
    it { is_expected.to respond_to(:subject) }
    it { is_expected.to respond_to(:teacher) }
    it { is_expected.to respond_to(:quota) }
    it { is_expected.to respond_to(:modality) }
    it { is_expected.to respond_to(:projector) }
    it { is_expected.to respond_to(:laboratory) }
  end

  describe 'valid?' do
    it 'should be valid' do
      analisis = described_class.new(code: 7557, subject: 'Analisis',
                                     teacher: 'Sirne', quota: 50, modality: 'tp',
                                     projector: false, laboratory: false)
      expect(analisis).to be_valid
    end

    it 'should raise exception when course is invalid' do
      expect do
        described_class.new(code: 751_57, subject: 'Analisis',
                            teacher: 'Sirne', quota: 50, modality: 'tp',
                            projector: false, laboratory: false)
      end.to raise_error(CourseError)
    end

    it 'should be invalid when code has more than four digits' do
      described_class.new(code: 751_57, subject: 'Analisis',
                          teacher: 'Sirne', quota: 50, modality: 'tp',
                          projector: false, laboratory: false)
    rescue CourseError => e
      expect(e.msg).to eq('codigo_erroneo')
    end

    it 'should be invalid when code has less than four digits' do
      described_class.new(code: 751, subject: 'Analisis',
                          teacher: 'Sirne', quota: 50, modality: 'tp',
                          projector: false, laboratory: false)
    rescue CourseError => e
      expect(e.msg).to eq('codigo_erroneo')
    end

    it 'should be invalid when code has a quota greater than 300' do
      described_class.new(code: 7515, subject: 'Analisis',
                          teacher: 'Sirne', quota: 301, modality: 'tp',
                          projector: false, laboratory: false)
    rescue CourseError => e
      expect(e.msg).to eq('cupo_excedido')
    end

    it 'should be invalid when it requests both lab and projector' do
      expect do
        described_class.new(code: 7515, subject: 'Analisis',
                            teacher: 'Sirne', quota: 31, modality: 'tp',
                            projector: true, laboratory: true)
      end.to raise_error(IncompatibleRequest)
    end

    it 'should be invalid when title has more than 50 characters' do
      described_class.new(code: 7513,
                          subject: 'Analisis12345678912345678912
                                   3456789123456789123456gdfgd7',
                          teacher: 'Sirne', quota: 30, modality: 'tp',
                          projector: false, laboratory: false)
    rescue CourseError => e
      expect(e.msg).to eq('nombre_erroneo')
    end

    it 'should be invalid when title is not present' do
      described_class.new(code: 7513,
                          subject: nil,
                          teacher: 'Sirne',
                          quota: 31, modality: 'tp',
                          projector: false,
                          laboratory: false)
    rescue CourseError => e
      expect(e.msg).to eq('nombre_erroneo')
    end

    it 'should not be invalid when couta is less or equal 0' do
      course = described_class.new(code: 7513,
                                   subject: 'Analisis',
                                   teacher: 'Sirne',
                                   quota: 0, modality: 'tp',
                                   projector: false,
                                   laboratory: false)

      expect(course.quota).to eq(0)
    end
  end

  course_param = { id: 1, code: 9532, subject: 'Memo',
                   teacher: 'villagra', quota: 1, modality: 'tp' }
  subject(:memo) { described_class.new(course_param) }

  describe 'when student applies' do
    course_param = { id: 1, code: 9532, subject: 'Memo',
                     teacher: 'villagra', quota: 1, modality: 'tp' }
    memo = described_class.new(course_param)

    params = { name: 'Jazmin Ferreiro', user_name: 'jaz2' }
    student = Student.new(params)
    student.inscribe_to(memo)

    it "the course's quota is the same " do
      expect(memo.quota).to equal(0)
    end

    params2 = { name: 'Jazmin Ferreiro', user_name: 'juana' }
    student2 = Student.new(params2)

    it 'the course can accept more student outside quota' do
      expect { student2.inscribe_to(memo) }.to raise_error(QuoteCompleteError)
    end
  end
end
