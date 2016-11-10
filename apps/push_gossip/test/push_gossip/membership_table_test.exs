defmodule PushGossip.MembershipTableTest do
  use ExUnit.Case, async: true
  alias PushGossip.MembershipTable.Row
  alias PushGossip.MembershipTable, as: Table

  describe "new/1" do
    test """
    Constructs a new table with one row (self)
    """ do
      assert %Table{self: :my_table, heartbeat_num: 0, rows: rows} = Table.new(:my_table)
      assert Map.size(rows) == 1
      assert %{my_table: %Row{heartbeat_num: 0, updated_at: updated_at}} = rows
      assert updated_at < System.monotonic_time()
      assert is_integer(updated_at)
    end
  end

  describe "update_self/1" do
    test """
    Increments heartbeat_num on table and the self row.
    Also updates self row updated_at.
    """ do
      rows = %{fred: %Row{heartbeat_num: 30, updated_at: System.monotonic_time()},
               dave: %Row{heartbeat_num: 22, updated_at: 5000}}
      table = %Table{heartbeat_num: 30, self: :fred, rows: rows}
      updated = Table.update_self(table)
      time_after = System.monotonic_time()
      assert updated.self == :fred
      assert updated.heartbeat_num == 31
      assert updated.rows.fred.heartbeat_num == 31
      assert updated.rows.fred.updated_at > rows.fred.updated_at
      assert updated.rows.fred.updated_at < time_after
      assert Map.size(updated.rows) == 2
      assert updated.rows.dave == rows.dave
    end
  end


  describe "random_row/1" do
    test """
    fetches a random row from the table.
    """ do
      rows = %{fred: %Row{heartbeat_num: 30, updated_at: System.monotonic_time()},
               jane: %Row{heartbeat_num: 36, updated_at: 7000},
               mary: %Row{heartbeat_num: 81, updated_at: 1500},
               dave: %Row{heartbeat_num: 22, updated_at: 5000}}
      table = %Table{heartbeat_num: 30, self: :fred, rows: rows}
      :rand.seed(:exsplus, {1, 1, 1})
      assert Table.random_row(table) == {:ok, :mary, rows.mary}
      :rand.seed(:exsplus, {2, 2, 2})
      assert Table.random_row(table) == {:ok, :jane, rows.jane}
    end

    test """
    returns :no_rows when the only row is self.
    """ do
      rows = %{fred: %Row{heartbeat_num: 30, updated_at: System.monotonic_time()}}
      table = %Table{heartbeat_num: 30, self: :fred, rows: rows}
      assert Table.random_row(table) == :no_rows
    end
  end
end
