Catalog::Import::Monitor.listen("/mnt/music/TMP") do |event|
  sleep 3
  files = Catalog::Import::FindFiles.files(event)
  files.each do |file|
    begin
      mover = Catalog::Import::MoveFile.new(source: file, base: "/mnt/music")
      if mover.relocate
        Catalog::Import::ImportFile.add(mover.new_path)
      end
    rescue Exception => e
      $stdout.puts e
    end
  end
end
