class Ckeditor::Asset < ActiveRecord::Base  # :nodoc:
  include Ckeditor::Orm::ActiveRecord::AssetBase
  include Ckeditor::Backend::Paperclip
end
