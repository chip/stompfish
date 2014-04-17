StompFish
=========

Setup
-----
* Install Ruby 2.x+

* Install Postgresql on your system.  This app uses Postgresql for all environments.
* Copy `config/database.yml.example` to `config/database.yml`
* Add your Postgresql _username_ and _password_ to `config/database.yml`
* Start Postgresql

* Copy `config/monitor_settings.yml.example` to `config/monitor_settings.yml`
* Add your _watch_ and _import_ directories to `config/monitor_settings.yml`
* _watch_ is the directory to monitor for new audio files.
* _import_ is the base directory to move new audio files.

* Install TagLib on your system. [TagLib](http://robinst.github.io/taglib-ruby/)

* Install FFmpeg on your system. [FFmpeg](http://www.ffmpeg.org/download.html)

* Install ElasticSearch. [ElasticSearch](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/setup.html#setup-installation)
* Start ElasticSearch

* Run bundler

* Create your databases: `rake db:create:all db:migrate db:test:prepare`

* Import your music: run `rake import:full`

* Check the `ImportLog` model/table for errors on import
