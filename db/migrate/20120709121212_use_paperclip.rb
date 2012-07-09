class UsePaperclip < ActiveRecord::Migration
  def self.up
    change_table :spree_customized_product_options do |t|
      t.remove :customization_image
      t.has_attached_file :customization_image
    end
  end

  def self.down
    drop_attached_file :spree_customized_product_options, :customization_image
    add_column :customized_product_options, :customization_image, :string
  end
end
