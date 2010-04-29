if defined? RAILS_ROOT
  locale_path = File.join RAILS_ROOT, 'config', 'locales', 'page_titles'
  File.makedirs locale_path
  
  Dir['locales/*'].each do |file|
    File.copy file, locale_path
  end
end