Sequel.migration do
  up do
    add_column :course, :created_on, Date
    add_column :course, :updated_on, Date
  end

  down do
    drop_column :course, :created_on
    drop_column :course, :updated_on
  end
end
