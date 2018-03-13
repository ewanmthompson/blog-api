echo "*** Read the posts, there should be none"
curl "http://localhost:3000/posts"
echo
echo
echo "*** Create some posts"
curl -H "Content-Type: application/json" -X POST -d '{"name": "Post 1", "url":"http://webapplog.com/es6", "text": "This is post 1"}'  "http://localhost:3000/posts"
echo
curl -H "Content-Type: application/json" -X POST -d '{"name": "Post 2", "url":"http://webapplog.com/es6", "text": "This is post 2"}'  "http://localhost:3000/posts"
echo
echo
echo "*** Read the posts, there should be two"
curl "http://localhost:3000/posts"
echo
echo
echo "*** Delete all posts"
curl -X DELETE "http://localhost:3000/posts/1"
echo
curl -X DELETE "http://localhost:3000/posts/0"
echo
echo
echo "*** Read the posts, there should be none"
curl "http://localhost:3000/posts"
