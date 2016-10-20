page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false


set :js_dir, 'js'
set :css_dir, 'css'

page '/index.html', :layout => :template
page '/location.html', :layout => :main_template

# Build-specific configuration
configure :build do
  # Minify CSS on build
   activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript
end