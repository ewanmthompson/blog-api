# blog-api

This is the Module 2 tutorial for the edX Introduction to NodeJS course.

This project implements a RESTful Blog API.

# Usage

$ npm i

$ node server.js

# Design

* An in-memory store is used to hold the blog data
* Route handling is split into separate files for blog posts and blog comments in the ./route directory, this is achieved using express.Router
* Data validation is done using express-validator https://github.com/ctavan/express-validator
* Validation code is in the same files as as the route handling in order to centralize CRUD code for each type of data (i.e blog posts and blog comments)


# Evolution and Difficulties

In the first cut I wrote my own validation routines. I later used express-validator to streamline the code. It took a while for me to figure out how to implement the validation in the routing, as in the examples the validation is done inline in "app.post" etc.

I also hit a snag trying to implement the recommended data structure for the in-memory store, the example on the website appears to have incorrect syntax for the entries in the "comments" array. I ended up storing an object for each comment, i.e. instead of:
[text: 'foo', text: 'bar']
I used instead:
[{text: 'foo'}, {text: 'bar'}]

# Testing

I created a bash script for testing "test.sh" which exercises all CRUD functions for posts and comments using curl. The shell has an optional parameter for sleep time between each curl request so you can see what is happening, e.g. "sh test.sh 2" to pause two seconds between each curl request.

When issues cropped up I used the intregrated debugger in Visual Studio Code to step through the code to diagnose the problem.

The test script now runs sucessfully against my code and all output appears to be correct.
