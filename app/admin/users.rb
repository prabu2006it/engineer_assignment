ActiveAdmin.register User do
  permit_params :email, :name

  index do
    selectable_column
    id_column
    column :email
    column :name
    column :created_at
    actions
  end

  filter :email
  filter :name

  show do
    panel("User Detail") do
      attributes_table_for resource do
        row :name
        row :email
      end
    end

    panel("Phone Numbers") do
      table_for(resource.phone_numbers) do
        column :number
        column :created_at
      end
    end
  end
end
