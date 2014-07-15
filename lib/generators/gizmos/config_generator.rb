# encoding: utf-8

module Gizmos
  class ConfigGenerator < Rails::Generators::Base

    source_root File.expand_path('../templates', __FILE__)

    def copy_config_file
      template 'gizmos_config.rb', 'config/initializers/gizmos_config.rb'
    end

  end
end
