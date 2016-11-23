class CreateResumeParses < ActiveRecord::Migration
  def change
    create_table :resume_parses do |t|

      t.timestamps null: false
    end
  end
end
