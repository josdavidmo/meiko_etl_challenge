# meiko_etl_challenge

Hi! Thanks for give me the opportunity to make this test, I am so glad to show what I can do and I hope it fills your expectations. This project is divided in three main parts:

1. Docker. Docker solution is complete and working. You can change passwords and usernames in movies.env file.
2. Backend. Backend solution was made in Django. Please refer to submodule to see documentation.
3. Frontend. Frontend solution is based on Angular Project. I'm sorry, I do not have enought time to finish it, if you give more time I can improve it. 

Please be free to make your observations in issues section. 


# Docker Solution

This takes images from ngnix and postgres made in alpine. So it does not take so much time to deploy it! All you need is `docker` and `docker-compose`. All you need to do is:

```
git clone https://github.com/josdavidmo/meiko_etl_challenge.git --recursive
cd meiko_etl_challenge
docker-compose build movies
docker-compose up movies
```

In your browser write `localhost` and you will see Django Home Page!. The docker-entrypoint run this for you:

```
python3 manage.py migrate
python3 manage.py collectstatic --noinput
mkdir -p fixtures
time python3 manage.py importmovies --file=data/movie_metadata.tar.xz
files=$(ls fixtures)
time python3 manage.py loaddata $files
```

You will see in shell the time taken to:
1. Create fixtures files.
2. Import data to database.

Please refer to backend submodule in order to see the strategy and design taken.









