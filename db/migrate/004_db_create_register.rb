Sequel.migration do
  up do
    create_table(:register) do
      primary_key :id
      Integer :code
      String  :student_username
      Integer :grade # grade is null while inscription
      Date    :created_on
      Date    :updated_on
    end
  end

  down do
    drop_table(:register)
  end
end
