Jekyll Site Compiler
===

This is a Ruby script powered by Sinatra. It acts as a Jekyll site compiler, as part of what would have been an iOS app for editing Jekyll-powered blogs on the go. It compiles a title and content through Jekyll, then hands back the compiled HTML for previewing.

The reason for this is to get the same result as is rendered by GitHub Pages - including Markdown sections (using the same rendering engine), code highlighting with Pygments, etc. It's more accurate and easier to maintain to just get Jekyll to do this as it would in production, rather than emulate it in iOS.

Using the script is as simple as sending sending the URL encoded post title and content as a POST request to `/build`, e.g:

	curl -X POST -d "title=MyFirstPost&content=Hello%20World" http://localhost:8888/build

Will result in the HTML:

	Hello World
