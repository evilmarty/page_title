module ActionController
  module PageTitle
    def self.included base
      base.class_eval do
        include InstanceMethods
        extend ClassMethods
      end
      
      base.send :helper_method, :page_title
    end
    
    module ClassMethods
      attr_writer :page_title
    end
    
    module InstanceMethods
      def page_title(options = {})
        @page_title || begin
          defaults = ["actions.#{action_name}".intern, '']

          controller_names = controller_path.split('/')
          controller_names.each do |c|
            defaults.unshift "controllers.#{controller_names.join('.')}.#{action_name}".intern
            controller_names.unshift
          end

          primary_lookup = defaults.shift
          options.reverse_merge! :scope => 'application.page_title', :default => defaults

          assigns = instance_variables.inject({}) do |hash, ivar|
            name = ivar.gsub(/@/, '')
            hash[name.intern] = instance_variable_get(ivar).to_s unless name.blank?
            hash
          end
          options.reverse_merge! assigns

          translate primary_lookup, options
        end
      end
    end
  end
end