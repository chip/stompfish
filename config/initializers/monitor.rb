directories = YAML.load_file("#{Rails.root}/config/monitor_settings.yml")[Rails.env]
import_dir = directories["import_dir"]
watch_dir = directories["watch_dir"]

Importors::AutoImport.start(import_dir: import_dir, watch_dir: watch_dir)
