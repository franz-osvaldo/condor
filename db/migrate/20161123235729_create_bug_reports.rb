class CreateBugReports < ActiveRecord::Migration[5.0]
  def change
    create_table :bug_reports do |t|
      t.references :user, foreign_key: true
      t.text :report

      t.timestamps
    end
  end
end
