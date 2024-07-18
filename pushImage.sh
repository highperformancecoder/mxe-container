#docker login --username=highperformancecoder 
docker build --pull --network=host --tag highperformancecoder/mxecontainer .
docker push highperformancecoder/mxecontainer
