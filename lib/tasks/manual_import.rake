directories = YAML.load_file("#{Rails.root}/config/monitor_settings.yml")[Rails.env]
namespace :import do
  desc "Begins full import (default import directory specified in config/monitor_settings.yml"
  task full: :environment do
    Importors::ManualImport.scan(directories["import_dir"]) do
      $stdout.print "."
    end
  end
end
