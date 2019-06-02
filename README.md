## PostgreSQL setup

Follow these steps to initialize the PostgreSQL databases:

1. Install PostgreSQL if needed. On Ubuntu you can do this by running:
`sudo apt-get install -y postgresql-9.5 postgresql-contrib postgresql-server-dev-9.5`
1. Create development and test databases by running:
`sudo -u postgres psql --dbname=postgres -f ./create_dev_and_test_dbs.sql`



## Run local app:
ruby app.rb -o0.0.0.0 -p3000

## Deploy URL 
https://astapor-api.herokuapp.com/welcome_message

## Run fitnesse test:
* Local:
  sudo docker run --rm --net=host -p9123:8080 -ebase_url=http://localhost:3000/  -eapi_token=`api token` registry.gitlab.com/fiuba-memo2/guarabot:latest
* Prod: 
  sudo docker run --rm --net=host -p9123:8080 -ebase_url=https://astapor-api.herokuapp.com/  -eapi_token=`api token` registry.gitlab.com/fiuba-memo2/guarabot:latest






