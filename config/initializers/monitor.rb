MONITOR_SETTINGS = YAML.load_file("#{Rails.root}/config/monitor_settings.yml")[Rails.env]
Importors::AutoImport.start!
