Ergo Butler
===

The Ergo butler is a Ruby script powered by Sinatra. It acts as a compiler for Ergo.

It's as simple as sending sending the post title and content as a POST request to `/build`, e.g:

	curl -X POST -d "title=MyFirstPost&content=Hello%20World" http://ergo-butler.herokuapp.com/build

Will result in the HTML:

	Hello World
