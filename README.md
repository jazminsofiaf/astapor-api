## Correr app con sinatra:
ruby app.rb -o0.0.0.0 -p3000

## Deploy URL 
https://astapor-api.herokuapp.com/welcome_message

## Correr fitnesse con docker:
* Local:
  sudo docker run --rm --net=host -p9123:8080 -ebase_url=http://localhost:3000/  -eapi_token=886923073:AAGBZ5lRk2r9o-tR1VU5vO6JcwZamkaFp1c registry.gitlab.com/fiuba-memo2/guarabot:latest
* Deployada 
  sudo docker run --rm --net=host -p9123:8080 -ebase_url=https://astapor-api.herokuapp.com/  -eapi_token=886923073:AAGBZ5lRk2r9o-tR1VU5vO6JcwZamkaFp1c registry.gitlab.com/fiuba-memo2/guarabot:latest






