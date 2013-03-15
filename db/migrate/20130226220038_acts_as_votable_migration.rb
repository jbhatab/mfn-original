class ActsAsVotableMigration < ActiveRecord::Migration
  def change
    create_table :votes do |t|

      t.references :votable, :polymorphic => true
      t.references :voter, :polymorphic => true

      t.boolean :vote_flag
      t.string :vote_scope

      t.timestamps
    end

    add_index :votes, [:votable_id, :votable_type]
    add_index :votes, [:voter_id, :voter_type]
    add_index :votes, [:voter_id, :voter_type, :vote_scope]
    add_index :votes, [:votable_id, :votable_type, :vote_scope]
  end

end
