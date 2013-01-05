Neo Similar
===========

Example Match Making site for people who are similar to me.
Uses Neo4j, the Neography Gem and the Facebook API.

Pre-Requisites
--------------

* You will need to get a Facebook Consumer Key and Secret on https://developers.facebook.com/apps
* Select the "user_location" and "friend_location" permissions.
* You will need Neo4j in order for your database.
* You will need Redis in order to use Sidekiq for background jobs.
* If using commercially please purchase https://wrapbootstrap.com/theme/tabula-portfolio-bootstrap-template-WB0M5SS50

Installation
----------------

    git clone git@github.com:maxdemarzi/neo_similar.git
    bundle install
    sudo apt-get install redis-server or brew install redis or install redis manually and start it with src/redis-server
    rake neo4j:install['enterprise','1.9.M03']
    rake neo4j:start
    export SESSION_SECRET=<your session secret>
    export FACEBOOK_APP_ID=<your facebook app id>
    export FACEBOOK_SECRET=<your facebook secret>
    export REDISTOGO_URL="redis://127.0.0.1:6379/"
    foreman start

On Heroku
---------

Install the Heroku toolbelt from https://toolbelt.heroku.com

    git clone git@github.com:maxdemarzi/neo_similar.git
    heroku apps:create neosimilar
    heroku config:add SESSION_SECRET=<your session secret>
    heroku config:add FACEBOOK_APP_ID=<your facebook app id>
    heroku config:add FACEBOOK_SECRET=<your facebook secret>
    heroku addons:add neo4j
    heroku addons:add redistogo
    git push heroku master
    heroku ps:scale worker=1

See it running live at http://neosimilar.heroku.com