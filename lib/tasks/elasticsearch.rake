namespace :elasticsearch do
  desc "Runs full indexing of ElasticSearch"
  task index: :environment do
    $stdout.puts "Indexing artists..."
    Artist.import

    $stdout.puts "Indexing albums..."
    Album.import

    $stdout.puts "Indexing songs..."
    Song.import

    $stdout.puts "Indexing genres..."
    Genre.import

    $stdout.puts "Indexing completed."
  end
end
