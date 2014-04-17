Setup
-----
### Ruby
1. Install Ruby 2.x+ (Recommended: [Rbenv](https://github.com/sstephenson/rbenv))

### Postgresql
1. Install Postgresql on your system.  This app uses Postgresql for all environments.
2. Copy `config/database.yml.example` to `config/database.yml`
3. Add your Postgresql _username_ and _password_ to `config/database.yml`
4. Start Postgresql

### Monitor Configuration
1. Copy `config/monitor_settings.yml.example` to `config/monitor_settings.yml`
2. Add your _watch_ and _import_ directories to `config/monitor_settings.yml`
3. _watch_ is the directory to monitor for new audio files.
4. _import_ is the base directory to move new audio files.

### Libraries
1. Install TagLib on your system. [TagLib](http://robinst.github.io/taglib-ruby/)
2. Install FFmpeg on your system. [FFmpeg](http://www.ffmpeg.org/download.html)

### Search
1. Install ElasticSearch. [ElasticSearch](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/setup.html#setup-installation)
2. Start ElasticSearch

### Rails Setup
1. Run bundler
2. Create your databases: `rake db:create:all db:migrate db:test:prepare`

### Add Songs to Database
1. Import your music: run `rake import:full`
2. Check the `ImportLog` model/table for errors on import
