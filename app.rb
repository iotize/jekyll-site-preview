require 'sinatra'
require 'date'
require 'fileutils'
require 'digest'
require 'jekyll'

def post_html(post_title, post_content)
  # Generate a unique hash from the content
  hash = Digest::SHA1.hexdigest(post_content)

  # Calculate directory paths
  temp_dir = File.join(settings.root, 'tmp')
  destination_dir = File.join(temp_dir, hash)
  site_dir = File.join(destination_dir, 'site')
  posts_dir = File.join(site_dir, '_posts')
  build_dir = File.join(destination_dir, 'build')
  
  puts "temp dir: #{temp_dir}"
  puts "dest dir: #{destination_dir}"
  puts "site dir: #{site_dir}"
  puts "posts dir: #{posts_dir}"
  puts "build dir: #{build_dir}"

  # Generate post path
  post_title = "Example"
  post_date = Date.today
  post_name = [ post_date.strftime("%Y-%m-%d"), post_title.downcase ].join('-') + '.md'
  post_path = File.join(posts_dir, post_name)
  
  puts "post path: #{post_path}"

  # Create the posts directory
  FileUtils::mkdir_p(posts_dir)

  # Add a _config.yml file
  file = File.open(File.join(site_dir, '_config.yml'), "w") do |f|
    f.puts('markdown: kramdown')
    f.puts('permalink: none')
  end

  # Add a post with today's date
  File.open(post_path, "w") do |f|
    f.write(post_content)
  end

  # Build it with Jekyll
  options = Jekyll::configuration({ 'source' => site_dir, 'destination' => build_dir, safe: true })
  site = Jekyll::Site.new(options)
  site.process

  # Figure out the compiled post path
  compiled_post_path = File.join(build_dir, post_title) + '.html'
  
  puts "compiled post path: #{compiled_post_path}"

  # Get HTML contents
  compiled_post_contents = File.read(compiled_post_path)
  
  # # Delete directory
  # FileUtils.rm_rf(destination_dir)
  
  # Return post HTML contents
  compiled_post_contents
end

get '/' do
  "Hello." + "<br/>Root: #{settings.root}"
end

get '/test' do
  post_html 'My First Post', 'Hello world!'
end

post '/build' do
  post_html params[:title], params[:content]
end
