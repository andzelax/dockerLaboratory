# build image
docker build --build-arg VERSION=2.0.0 -t mywebapp .
# run contener
docker run -d -p 8080:80 --name webservernginx mywebapp
#test app
curl http://localhost:8080/
