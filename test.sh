start_dir=start

docker build . -t growth-test
# simulate the start of the notebook server with start scripts
docker run --user root -p 8888:8888 -v $PWD/$start_dir:/home/admin/start growth-test
