# frozen_string_literal: true

# comment
class CoursesRepository < BaseRepository
  self.table_name = :course
  self.model_class = 'Course'

  def find_by_code(code)
    load_collection dataset.where(code: code)
  end

  def search_by_subject(subject)
    load_collection dataset.where(Sequel.like(:subject, "%#{subject}%"))
  end

  protected

  def load_object(a_record)
    curse = super
    curse
  end

  def changeset(offer)
    {
      title: offer.title,
      location: offer.location,
      description: offer.description,
      experience: offer.experience,
      is_active: offer.is_active,
      user_id: offer.owner&.id || offer.user_id
    }
  end
end
