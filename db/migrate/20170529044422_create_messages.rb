class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.text :content
      t.string :event

      t.timestamps
    end

    add_reference :messages, :user, index: true
  end
end
