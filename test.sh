echo "======================================================================================"
SLEEPTIME=${1:-0}
echo "*** Read the posts, there should be none"
curl "http://localhost:3000/posts"
sleep $SLEEPTIME
echo
echo
echo "*** Create some posts"
curl -H "Content-Type: application/json" -X POST -d '{"name": "Post 1", "url":"http://webapplog.com/es6", "text": "This is post 1"}'  "http://localhost:3000/posts"
sleep $SLEEPTIME
echo
curl -H "Content-Type: application/json" -X POST -d '{"name": "Post 2", "url":"http://webapplog.com/es6", "text": "This is post 2"}'  "http://localhost:3000/posts"
sleep $SLEEPTIME
echo
curl -H "Content-Type: application/json" -X POST -d '{"name": "Post 3", "url":"http://webapplog.com/es6", "text": "This is post 3"}'  "http://localhost:3000/posts"
sleep $SLEEPTIME
echo
echo
echo "*** Update the second post"
curl -H 'Content-Type: application/json' -X PUT -d '{"name": "Post 2 updated", "url":"http://webapplog.com/es6", "text": "This is post 2 updated"}' "http://localhost:3000/posts/1"
sleep $SLEEPTIME
echo
echo
echo "*** Read the posts, there should be three"
curl "http://localhost:3000/posts"
sleep $SLEEPTIME
echo
echo
echo "*** Read the second post, should return Post 2"
curl "http://localhost:3000/posts?postid=1"
sleep $SLEEPTIME
echo
echo
echo "*** Delete a post"
curl -X DELETE "http://localhost:3000/posts/0"
sleep $SLEEPTIME
echo
echo
echo "*** Read the posts, there should be two"
curl "http://localhost:3000/posts"
sleep $SLEEPTIME
echo
echo
echo "*** Create some comments"
curl -H "Content-Type: application/json" -X POST -d '{"text": "This is post 2 Comment 1"}'  "http://localhost:3000/posts/0/comments"
sleep $SLEEPTIME
echo
curl -H "Content-Type: application/json" -X POST -d '{"text": "This is post 2 Comment 2"}'  "http://localhost:3000/posts/0/comments"
sleep $SLEEPTIME
echo
curl -H "Content-Type: application/json" -X POST -d '{"text": "This is post 2 Comment 3"}'  "http://localhost:3000/posts/0/comments"
sleep $SLEEPTIME
echo
curl -H "Content-Type: application/json" -X POST -d '{"text": "This is post 3 Comment 1"}'  "http://localhost:3000/posts/1/comments"
sleep $SLEEPTIME
echo
curl -H "Content-Type: application/json" -X POST -d '{"text": "This is post 3 Comment 2"}'  "http://localhost:3000/posts/1/comments"
sleep $SLEEPTIME
echo
curl -H "Content-Type: application/json" -X POST -d '{"text": "This is post 3 Comment 3"}'  "http://localhost:3000/posts/1/comments"
sleep $SLEEPTIME
echo
echo
echo "*** Read the posts, there should be two and they should have three comments each"
curl "http://localhost:3000/posts"
sleep $SLEEPTIME
echo
echo
echo "*** Update some comments"
curl -H 'Content-Type: application/json' -X PUT -d '{"text": "This is post 2 comment 1 updated"}' "http://localhost:3000/posts/0/comments/0"
sleep $SLEEPTIME
echo
curl -H 'Content-Type: application/json' -X PUT -d '{"text": "This is post 3 comment 2 updated"}' "http://localhost:3000/posts/1/comments/1"
sleep $SLEEPTIME
echo
echo
echo "*** Read the comments, there should be three for each post"
curl "http://localhost:3000/posts/0/comments"
sleep $SLEEPTIME
echo
curl "http://localhost:3000/posts/1/comments"
sleep $SLEEPTIME
echo
echo
echo "*** Read the second comment of the second post"
curl "http://localhost:3000/posts/1/comments?commentid=1"
sleep $SLEEPTIME
echo
echo
echo "*** Delete some comments"
curl -X DELETE "http://localhost:3000/posts/0/comments/1"
sleep $SLEEPTIME
echo
curl -X DELETE "http://localhost:3000/posts/1/comments/0"
sleep $SLEEPTIME
echo
echo
echo "*** Read the comments, there should be two for each post"
curl "http://localhost:3000/posts/0/comments"
sleep $SLEEPTIME
echo
curl "http://localhost:3000/posts/1/comments"
sleep $SLEEPTIME
echo
echo
echo "*** Create a post, should return 400 due to missing URL"
curl -H "Content-Type: application/json" -X POST -d '{"name": "Post 4", "text": "This is post 4"}'  "http://localhost:3000/posts"
sleep $SLEEPTIME
echo
echo
echo "*** Update a post, should return 400 due to missing text"
curl -H 'Content-Type: application/json' -X PUT -d '{"name": "Post updated with error", "url":"http://webapplog.com/es6"}' "http://localhost:3000/posts/0"
sleep $SLEEPTIME
echo
echo
echo "*** Delete a post, should return 400 due to invalid postid"
curl -X DELETE "http://localhost:3000/posts/xxx"
sleep $SLEEPTIME
echo
echo
echo "*** Delete a post, should return 400 due to out of range postid"
curl -X DELETE "http://localhost:3000/posts/2"
sleep $SLEEPTIME
echo
echo
echo "*** Delete all posts"
curl -X DELETE "http://localhost:3000/posts/1"
sleep $SLEEPTIME
echo
curl -X DELETE "http://localhost:3000/posts/0"
sleep $SLEEPTIME
echo
echo
echo "*** Read the posts, there should be none"
curl "http://localhost:3000/posts"
