# frozen_string_literal: true

class CreateCurses < ActiveRecord::Migration[5.2]
  def change
    create_table :curses do |t|
      t.integer :code
      t.string :subject
      t.string :teacher
      t.integer :quota, default: 30
      t.string :modality
    end
  end
  end
