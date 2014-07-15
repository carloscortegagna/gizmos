# encoding: utf-8

module Gizmos
  class InstallGenerator < Rails::Generators::Base

    source_root File.expand_path('../templates', __FILE__)

    def install
      routes = File.open(Rails.root.join("config/routes.rb")).try :read
      rails_admin_initializer = (File.open(Rails.root.join("config/initializers/rails_admin.rb")) rescue nil).try :read

      if !defined?(Devise) || !routes.index("devise_for")
        say 'Devise not installed. Please install it first...'
      elsif rails_admin_initializer.blank?
        say 'RailsAdmin not installed. Please install it first...'
      else
        template 'gizmos_config.rb', 'config/initializers/gizmos_config.rb'
        route "mount Gizmos::Engine => 'gizmos'"
      end
    end

  end
end
