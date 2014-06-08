docker stop rails
docker rm rails
docker build -t rails /monsoon-worldcup
docker run -d -v /monsoon-worldcup:/monsoon-worldcup -p 3000:3000 --link postgres:db --name rails rails:latest
