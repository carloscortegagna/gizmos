# encoding: utf-8

module Gizmos
  class InstallGenerator < Rails::Generators::Base

    source_root File.expand_path('../templates', __FILE__)

    def copy_config_file
      template 'gizmos_config.rb', 'config/initializers/gizmos_config.rb'
    end

    def add_routes
      route "mount Gizmos::Engine => ''"
    end

  end
end
