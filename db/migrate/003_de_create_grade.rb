Sequel.migration do
  up do
    create_table(:grade) do
      primary_key :id
      Integer :code
      Integer :student_id
      Grade :grade
    end
  end

  down do
    drop_table(:grade)
  end
end
