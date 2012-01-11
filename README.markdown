AlterTable
==========
This gem provides the ability to perform multiple alterations to a table
from a Rails migration.  Instead of:

    add_column :table, :foo, :string
    add_column :table, :bar, :decimal, :precision => 10
    remove_column :table, :baz
    add_index :table, :foo
    remove_index :table, [ :a, :b ]
    rename_column :table, :original, :new, :string

Where each of these statements executes as a separate ALTER TABLE
statement; you can do:

    alter_table(:table) do
      add_column :foo, :string
      add_column :bar, :decimal, :precision => 10
      remove_column :baz
      add_index :foo
      remove_index [ :a, :b ]
      rename_column :original, :new, :string
    end

And these updates will be done in a single ALTER TABLE statement.  In
theory this should be more efficient.
