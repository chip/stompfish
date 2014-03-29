Catalog::Monitors::DirectoryWatcher.listen("/mnt/music/TMP") do |event|
  sleep 3
  files = FileystemTools::FindFiles.files(event)
  files.each do |file|
    begin
      mover = FileystemTools::MoveFile.new(source: file, base: "/mnt/music")
      if mover.relocate
        Catalog::Importors::SingleFile.add(mover.new_path)
      end
    rescue Exception => e
      $stdout.puts e
    end
  end
end
