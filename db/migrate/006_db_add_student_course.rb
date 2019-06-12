Sequel.migration do
  up do
    add_column :course, :students, Integer, default: 0
  end

  down do
    drop_column :course, :created_on
  end
end
