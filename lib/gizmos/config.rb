require 'active_support/configurable'

module Gizmos

  def self.configure(&block)
    yield @config ||= Gizmos::Configuration.new
  end

  # Global settings for Gizmos
  def self.config
    @config
  end

  class Configuration
    include ActiveSupport::Configurable
    config_accessor :admin_scope
    config_accessor :color_palette
    config_accessor :appendable_types

    def param_name
      config.param_name.respond_to?(:call) ? config.param_name.call : config.param_name
    end

    # define param_name writer (copied from AS::Configurable)
    writer, line = 'def param_name=(value); config.param_name = value; end', __LINE__
    singleton_class.class_eval writer, __FILE__, line
    class_eval writer, __FILE__, line
  end

  configure do |config|
    config.admin_scope = :current_user
    config.color_palette = []
    config.appendable_types = []
  end

end
