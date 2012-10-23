module Tesseract
  module SiteConfig
    extend self

    def load_config
      @_config ||= YAML.load_file(Rails.root + 'config/keys.yml')[Rails.env]
    end

    def [](name)
      load_config[name]
    end
  end
end