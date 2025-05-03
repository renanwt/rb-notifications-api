
```
bundle install
```
Remove the .example from the .env and fill it:
```
SENDGRID_API_KEY=2wergergrigjrieg
```

To Run sidekiq we need to have redis 7.0.0 up and running:
```
sudo add-apt-repository ppa:redislabs/redis
sudo apt update
sudo apt install redis
redis-server --version
```
