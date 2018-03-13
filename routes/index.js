// blog-api - implements a blog api with blog posts and comments
//   for edX - Introduction to NodeJS - Module 2 assignment
// index.js - request routing handler
// 13 March 2018 - Ewan T.

var express = require('express');
var router = express.Router();
var posts = require('./posts')
var comments = require('./comments')

router.get('/posts', posts.validatePostIdOptional, posts.getPosts);
router.post('/posts', posts.validatePostDetails, posts.addPost);
router.put('/posts/:postid', posts.validatePostIdMandatory, posts.validatePostDetails, posts.updatePost);
router.delete('/posts/:postid', posts.validatePostIdMandatory, posts.removePost);
router.get('/posts/:postid/comments', comments.validatePostId, comments.validateCommentIdOptional, comments.getComments);
router.post('/posts/:postid/comments', comments.validatePostId, comments.validateCommentDetails, comments.addComment);
router.put('/posts/:postid/comments/:commentid', comments.validatePostId, comments.validateCommentIdMandatory, comments.validateCommentDetails, comments.updateComment);
router.delete('/posts/:postid/comments/:commentid', comments.validatePostId, comments.validateCommentIdMandatory, comments.removeComment);

// Catch-all for unsupported requests
router.all('*', function(req, res, next) {
  res.sendStatus(404)
});

module.exports = router;
