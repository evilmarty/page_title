module PageTitle
  module Controller
    def self.included base
      base.class_eval do
        attr_accessor :page_title
        hide_action :page_title, :page_title=
      end
    end
  end
end