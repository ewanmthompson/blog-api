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
