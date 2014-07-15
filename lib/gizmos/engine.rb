module Gizmos
  class Engine < ::Rails::Engine
    # isolate_namespace Gizmos

    initializer :append_migrations do |app|
      unless app.root.to_s == root.to_s
        config.paths["db/migrate"].expanded.each do |expanded_path|
          ActiveRecord::Tasks::DatabaseTasks.migrations_paths << expanded_path
        end
      end
    end

  end
end
