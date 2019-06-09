Sequel.migration do
  up do
    create_table(:student) do
      primary_key :id
      String :name
      String :user_name
      Date    :created_on
      Date    :updated_on
    end
  end

  down do
    drop_table(:student)
  end
end
