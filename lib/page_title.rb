require 'action_controller/page_title'

ActionController::Base.class_eval do
  include ActionController::PageTitle
end