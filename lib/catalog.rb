require 'catalog_record/album_record'
require 'catalog_record/artist_record'
require 'catalog_record/genre_record'
require 'catalog_record/release_date_record'
require 'catalog_record/song_record'
require 'catalog_record/song_file_record'

class Catalog
  attr_reader :tags

  def initialize(tags)
    @tags = tags
  end

  def create
    updateable = Song.find(song.id)
    updateable.song_file = song_file
    updateable.save
  end

  def self.create(tags)
    new(tags).create
  end

  private
  def artist
    CatalogRecord::ArtistRecord.add(name: tags.artist)
  end

  def genre
    CatalogRecord::GenreRecord.add(name: tags.genre)
  end

  def release_date
    CatalogRecord::ReleaseDateRecord.add(year: tags.date)
  end

  def album
    CatalogRecord::AlbumRecord.add(title: tags.album, artist: artist,
                                            genre: genre, release_date: release_date)
  end

  def song_file
    CatalogRecord::SongFileRecord.add(tags, fileable_id: song.id)
  end

  def song
    @created_song ||= CatalogRecord::SongRecord.add(tags, album)
  end
end
