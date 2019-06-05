# frozen_string_literal: true

Sequel.migration do
  up do
    create_table(:course) do
      primary_key :id
      Integer :code
      String :subject
      String :teacher
      Integer :quota, default: 30
      String :modality
      String :laboratory
      String :projector
    end
  end

  down do
    drop_table(:course)
  end
end
