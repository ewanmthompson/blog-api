// blog-api - implements a blog api with blog posts and comments
//   for edX - Introduction to NodeJS - Module 2 assignment
// posts.js - implements routes for blog posts CRUD
// 13 March 2018 - Ewan T.

const express = require('express');
const { check, validationResult } = require('express-validator/check');
const { matchedData, sanitize } = require('express-validator/filter');

validatePostIdOptional = [
  check('postid')
    .trim()
    .optional()
    .isInt().withMessage("PostId not numeric")
    .custom((value, { req }) => value >= 0 && value < req.store.posts.length).withMessage("PostId out of bounds")
    .toInt()
]

validatePostIdMandatory = [
  check('postid')
    .trim()
    .exists().withMessage('PostId missing')
    .isInt().withMessage("PostId not numeric")
    .custom((value, { req }) => value >= 0 && value < req.store.posts.length).withMessage("PostId out of bounds")
    .toInt()
]

validatePostDetails = [
  check('name').trim().exists().withMessage('Name missing'),
  check('url').trim().exists().withMessage('Url missing'),
  check('text').trim().exists().withMessage('Text missing')
]

function getPostDetails(req, res) {
  const allData = matchedData(req)
  let postDetails = {
      name: allData.name,
      url: allData.url,
      text: allData.text
  }
  return postDetails
}

module.exports = {
  validatePostIdOptional,
  validatePostIdMandatory,
  validatePostDetails,
  getPosts(req, res) {
    const errors = validationResult(req)
    if (!errors.isEmpty()) {
      return res.status(422).json({errors: errors.mapped()})
    }
    let jsonPosts = (matchedData(req).postid) ? req.store.posts[matchedData(req).postid] : req.store.posts
    res.status(200).json(jsonPosts)
  },
  addPost(req, res) {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(422).json({ errors: errors.mapped() });
    }
    let newPost = getPostDetails(req, res)
    newPost.comments = []
    let postId = req.store.posts.length
    req.store.posts.push(newPost)
    res.status(201).send({postid: postId})
  },
  updatePost(req, res) {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(422).json({ errors: errors.mapped() });
    }
    let postId = matchedData(req).postid
    let newPost = getPostDetails(req, res)
    newPost.comments = req.store.posts[postId].comments
    req.store.posts[postId] = newPost
    res.status(200).send(req.store.posts[postId])
},
  removePost(req, res) {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(422).json({ errors: errors.mapped() });
    }
    let postId = matchedData(req).postid
    req.store.posts.splice(postId, 1)
    res.status(204).send()
  }
}
