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
end
