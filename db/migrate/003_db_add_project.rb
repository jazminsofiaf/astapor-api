Sequel.migration do
  up do
    add_column :course, :projector, TrueClass, default: false
    add_column :course, :laboratory, TrueClass, default: false
  end

  down do
    drop_column :course, :projector
    drop_column :course, :laboratory
  end
end
