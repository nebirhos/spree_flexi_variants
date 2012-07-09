module Spree
  # in populate, params[:customization] contains all the fields supplied by
  # the customization_type_view. Those values are saved in this class
  class CustomizedProductOption < ActiveRecord::Base

    belongs_to :product_customization
    belongs_to :customizable_product_option

    attr_accessible :customization_image
    has_attached_file :customization_image,
                      :styles => { :mini => ["48x48#", :png] },
                      :url => '/spree/artworks/:id/:style/:basename.:extension',
                      :path => ':rails_root/public/spree/artworks/:id/:style/:basename.:extension'

    # Load user defined paperclip settings
    if Spree::Config[:use_s3]
      s3_creds = { :access_key_id => Spree::Config[:s3_access_key], :secret_access_key => Spree::Config[:s3_secret], :bucket => Spree::Config[:s3_bucket] }
      Spree::CustomizedProductOption.attachment_definitions[:customization_image][:storage] = :s3
      Spree::CustomizedProductOption.attachment_definitions[:customization_image][:s3_credentials] = s3_creds
      Spree::CustomizedProductOption.attachment_definitions[:customization_image][:s3_headers] = ActiveSupport::JSON.decode(Spree::Config[:s3_headers])
      Spree::CustomizedProductOption.attachment_definitions[:customization_image][:bucket] = Spree::Config[:s3_bucket]
    end

    Spree::CustomizedProductOption.attachment_definitions[:customization_image][:styles] = ActiveSupport::JSON.decode(Spree::Config[:attachment_styles])
    Spree::CustomizedProductOption.attachment_definitions[:customization_image][:path] = Spree::Config[:attachment_path]
    Spree::CustomizedProductOption.attachment_definitions[:customization_image][:default_url] = Spree::Config[:attachment_default_url]
    Spree::CustomizedProductOption.attachment_definitions[:customization_image][:default_style] = Spree::Config[:attachment_default_style]

    def empty?
      value.empty? && !customization_image?
    end

  end
end
