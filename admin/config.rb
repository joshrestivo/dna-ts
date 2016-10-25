page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false


set :js_dir, 'js'
set :css_dir, 'css'
set :fonts_dir,  "fonts"

page '/index.html', :layout => :main_template
page '/login.html', :layout => :template
page '/alert_types.html', :layout => :main_template
page '/client_resources.html', :layout => :main_template

# Build-specific configuration
configure :build do
  # Minify CSS on build
   activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript
end