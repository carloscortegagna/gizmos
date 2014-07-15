class CreateGizmos < ActiveRecord::Migration
  def change
    create_table :gizmos do |t|
      t.integer :status, default: 0
      t.string :background_color
      t.references :contentable, polymorphic: true, index: true
      t.references :content, polymorphic: true, index: true
      t.integer :position, default: 1
      t.boolean :is_yeld, default: false

      t.timestamps
    end

    add_index :gizmos, :status
    add_index :gizmos, :position
  end
end
