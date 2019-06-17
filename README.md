## PostgreSQL setup

Follow these steps to initialize the PostgreSQL databases:

1. Install PostgreSQL if needed. On Ubuntu you can do this by running:
`sudo apt-get install -y postgresql-9.5 postgresql-contrib postgresql-server-dev-9.5`
1. Create development and test databases by running:
`sudo -u postgres psql --dbname=postgres -f ./create_dev_and_test_dbs.sql`
1. If you need to delete the database execute `sudo -u postgres psql --dbname=postgres -f ./delete_dbs.sql` and the previus command again



## Run local app:


1. Run **_bundle install --without staging production_**, to install all application dependencies
1. Run **_bundle exec rake_**, to run all tests and ensure everything is properly setup
1. Run **_RACK_ENV=development bundle exec rake db:migrate db:seed_**, to setup the development database
1. Run **_bundle exec padrino start -h 0.0.0.0_**, to start the application

## Deploy URL 
https://astapor-api.herokuapp.com/

## Run fitnesse test:
* Local:
  sudo docker run --rm --net=host -p9123:8080 -ebase_url=http://localhost:3000/  -eapi_token=`api token` registry.gitlab.com/fiuba-memo2/guarabot:latest
* Prod: 
  sudo docker run --rm --net=host -p9123:8080 -ebase_url=https://astapor-api.herokuapp.com/  -eapi_token=`api token` registry.gitlab.com/fiuba-memo2/guarabot:latest






