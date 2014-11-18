class AddBannerImageToTrip < ActiveRecord::Migration
  def change
    add_column :trips, :banner_image, :string, :after => :name
  end
end
