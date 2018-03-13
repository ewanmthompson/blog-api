// blog-api - implements a blog api with blog posts and comments
//   for edX - Introduction to NodeJS - Module 2 assignment
// comments.js - implements routes for blog comments CRUD
// 13 March 2018 - Ewan T.

const express = require('express');
const { check, validationResult } = require('express-validator/check');
const { matchedData, sanitize } = require('express-validator/filter');

validatePostId = [
  check('postid')
    .trim()
    .exists().withMessage('PostId missing')
    .isInt().withMessage("PostId not numeric")
    .custom((value, { req }) => value >= 0 && value < req.store.posts.length)
      .withMessage("PostId out of bounds")
    .toInt()
]

validateCommentIdOptional = [
  check('commentid')
    .trim()
    .optional()
    .isInt().withMessage("CommentId not numeric")
    .custom((value, { req }) => value >= 0 && value < req.store.posts[matchedData(req).postid].comments.length)
      .withMessage("CommentId out of bounds")
    .toInt()
]

validateCommentIdMandatory = [
  check('commentid')
    .trim()
    .exists().withMessage('CommentId missing')
    .isInt().withMessage("CommentId not numeric")
    .custom((value, { req }) => value >= 0 && value < req.store.posts[matchedData(req).postid].comments.length)
      .withMessage("CommentId out of bounds")
    .toInt()
]

validateCommentDetails = [
  check('text').trim().exists().withMessage('Comment text missing')
]

module.exports = {
  validatePostId,
  validateCommentIdMandatory,
  validateCommentIdOptional,
  validateCommentDetails,
  getComments(req, res) {
    const errors = validationResult(req)
    if (!errors.isEmpty()) {
      return res.status(422).json({errors: errors.mapped()})
    }
    let postId = matchedData(req).postid
    let jsonComments = (matchedData(req).commentid)
      ? req.store.posts[postId].comments[matchedData(req).commentid]
      : req.store.posts[postId].comments
    res.status(200).json(jsonComments)
  },
  addComment(req, res) {
    const errors = validationResult(req)
    if (!errors.isEmpty()) {
      return res.status(422).json({errors: errors.mapped()})
    }
    let postId = matchedData(req).postid
    let commentId = req.store.posts[postId].comments.length
    let newComment = {text: matchedData(req).text}
    req.store.posts[postId].comments.push(newComment)
    res.status(201).send({postid: postId, commentid: commentId})
  },
  updateComment(req, res) {
    const errors = validationResult(req)
    if (!errors.isEmpty()) {
      return res.status(422).json({errors: errors.mapped()})
    }
    let postId = matchedData(req).postid
    let commentId = matchedData(req).commentid
    let newComment = {text: matchedData(req).text}
    req.store.posts[postId].comments[commentId] = newComment
    res.status(200).send(req.store.posts[postId].comments[commentId])
  },
  removeComment(req, res) {
    const errors = validationResult(req)
    if (!errors.isEmpty()) {
      return res.status(422).json({errors: errors.mapped()})
    }
    let postId = matchedData(req).postid
    let commentId = matchedData(req).commentid
    req.store.posts[postId].comments.splice(commentId, 1)
    res.status(204).send()
  }
}
