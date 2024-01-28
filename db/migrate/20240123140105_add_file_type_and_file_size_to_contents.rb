class AddFileTypeAndFileSizeToContents < ActiveRecord::Migration[7.2]
  def change
    add_column :contents, :file_type, :string
    add_column :contents, :file_size, :string
  end
end
