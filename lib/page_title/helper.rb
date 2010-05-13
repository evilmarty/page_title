module PageTitle
  module Helper
    def page_title options = {}
      @page_title || begin
        defaults = [:"actions.#{action_name}", '']
        
        controller_names = controller_path.split('/')
        controller_names.each do |c|
          defaults.unshift :"controllers.#{controller_names.join('.')}.#{action_name}"
          controller_names.unshift
        end

        primary_lookup = defaults.shift
        options.reverse_merge! :scope => :page_title, :default => defaults

        assigns = instance_variables.inject({}) do |hash, ivar|
          name = ivar.gsub(/@/, '')
          hash[name.intern] = instance_variable_get(ivar).to_s unless name.blank?
          hash
        end
        options.reverse_merge! assigns
        
        translate primary_lookup, options
      end
    end
    
    def title_for_page_header *titles
      options = titles.extract_options!.reverse_merge :delimiter => ' - '
      titles.reject(&:blank?).map { |t| html_escape(t) } * options[:delimiter]
    end
  end
end