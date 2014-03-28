Catalog::Import::Monitor.listen("/mnt/music", ignore: "/mnt/music/TMP") do |event|
  Catalog::Import::RecursiveImport.scan(event)
end
