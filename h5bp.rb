# See README for additional information.
# Written by: Russ Frisch
# http://github.com/russfrisch/h5bp-rails

# Download HTML5 Boilerplate plugins.js (converted to CoffeeScript)
get "https://github.com/russfrisch/h5bp-rails/raw/master/assets/plugins.js.coffee", "app/assets/javascripts/plugins.js.coffee"

# Download and merge HTML5 Boilerplate stylesheet with application.css
inside('app/assets/stylesheets/') do
  FileUtils.rm_rf 'application.css'
  FileUtils.touch 'application.css'
end
prepend_to_file 'app/assets/stylesheets/application.css' do
  " /*
 * This is a manifest file that'll automatically include all the stylesheets available in this directory
 * and any sub-directories. You're free to add application-wide styles to this file and they'll appear at
 * the top of the compiled file, but it's generally better to create a new file per style scope.
 *= require normalize
 *= require application-pre
 *= require_self
 *= require application-post
*/

"
end
get "https://github.com/h5bp/html5-boilerplate/raw/master/css/main.css", "app/assets/stylesheets/application-post.css"
get "https://github.com/h5bp/html5-boilerplate/raw/master/css/main.css", "app/assets/stylesheets/application-pre.css"
get "https://github.com/h5bp/html5-boilerplate/raw/master/css/normalize.css", "app/assets/stylesheets/normalize.css"
gsub_file 'app/assets/stylesheets/application-pre.css', /\/\*\s=*\n\s*Helper classes.*/m, ''
gsub_file 'app/assets/stylesheets/application-post.css', /\A.*Author's custom styles\s*=*\s\*\//m, ''
gsub_file 'app/assets/stylesheets/application-pre.css', /==\|==/, '==|==.'
gsub_file 'app/assets/stylesheets/application-post.css', /==\|==/, '==|==.'

# Download HTML5 Boilerplate site root assets
get "https://github.com/russfrisch/html5-boilerplate/raw/master/apple-touch-icon-114x114-precomposed.png", "public/apple-touch-icon-114x114-precomposed.png"
get "https://github.com/russfrisch/html5-boilerplate/raw/master/apple-touch-icon-57x57-precomposed.png", "public/apple-touch-icon-57x57-precomposed.png"
get "https://github.com/russfrisch/html5-boilerplate/raw/master/apple-touch-icon-72x72-precomposed.png", "public/apple-touch-icon-72x72-precomposed.png"
get "https://github.com/russfrisch/html5-boilerplate/raw/master/apple-touch-icon-precomposed.png", "public/apple-touch-icon-precomposed.png"
get "https://github.com/russfrisch/html5-boilerplate/raw/master/apple-touch-icon.png", "public/apple-touch-icon.png"
get "https://github.com/russfrisch/html5-boilerplate/raw/master/crossdomain.xml", "public/crossdomain.xml"
get "https://github.com/russfrisch/html5-boilerplate/raw/master/humans.txt", "public/humans.txt"
get "https://github.com/russfrisch/html5-boilerplate/raw/master/.htaccess", "public/.htaccess"

# Update application.html.erb with HTML5 Boilerplate index.html content
inside('app/views/layouts') do
  FileUtils.rm_rf 'application.html.erb'
end
get "https://github.com/russfrisch/html5-boilerplate/raw/master/index.html", "app/views/layouts/application.html.erb"
gsub_file 'app/views/layouts/application.html.erb', /<link rel="stylesheet" href="css\/style.css">/ do
  "<%= stylesheet_link_tag \"application\" %>"
end
gsub_file 'app/views/layouts/application.html.erb', /<script.*<\/head>/mi do
   "<%= javascript_include_tag \"modernizr\" %>
</head>"
end
gsub_file 'app/views/layouts/application.html.erb', /<meta charset="utf-8">/ do
  "<meta charset=\"utf-8\">
  <%= csrf_meta_tag %>"
end
gsub_file 'app/views/layouts/application.html.erb', /<div id="container">[\s\S]*<\/div>/, '<%= yield %>'
gsub_file 'app/views/layouts/application.html.erb', /<!-- JavaScript[\s\S]*!-- end scripts-->/, '<%= javascript_include_tag "application" %>'

# Add Modernizr-Rails dependency to get Modernizr.js support,
# optional blueprint-rails, coffeebeans, and Heroku dependencies.
gsub_file 'Gemfile', /gem 'jquery-rails'/ do
  "# JavasScript libs
gem 'jquery-rails'
gem 'modernizr-rails'

# Stylesheet libs
# gem 'blueprint-rails'

# Ajax request CoffeeScript support
# gem 'coffeebeans'

# Heroku deployment requirements
# group :production do
#   gem 'therubyracer-heroku'
#   gem 'pg'
# end
"
end