namespace :import do
  desc "Begins full import (default import directory specified in config/monitor_settings.yml"
  task full: :environment do
    Importors::Recursive.scan(MONITOR_SETTINGS["import_dir"]) do
      $stdout.print "."
    end
  end
end
