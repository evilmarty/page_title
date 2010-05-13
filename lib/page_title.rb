require 'page_title/controller'
require 'page_title/helper'

ActionController::Base.class_eval do
  include PageTitle::Controller
end

ActionView::Base.class_eval do
  include PageTitle::Helper
end