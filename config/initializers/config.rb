require 'i18n/core_ext/hash' # for deep_symbolize_keys
CONFIG = YAML.load_file("#{Rails.root.to_s}/config/config.yml")[Rails.env].deep_symbolize_keys
