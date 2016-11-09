defmodule PushGossip.MembershipTable.RowTest do
  use ExUnit.Case, async: true
  alias PushGossip.MembershipTable.Row

  describe "update/2" do
    test """
    If the new row has a lower `heartbeat_num` it is older and has no new
    information for the row.

    This is true even if the `updated_at` is greater as this comes from two
    local clocks that may be out of sync.

    Here we do not update the row.
    """
    do
      row = %Row{ heartbeat_num: 5, updated_at: 2 }
      older_row = %Row{ heartbeat_num: 4, updated_at: 3 }
      assert Row.update(row, older_row) == row
    end

    test """
    If the new row has a lower heartbeat num it is newer.

    In this instance we take the newer `heartbeat_num` and set the
    `updated_at` to local now.
    """
    do
      row = %Row{ heartbeat_num: 5, updated_at: 0 }
      newer_row = %Row{ heartbeat_num: 6, updated_at: 0 }
      time_before = System.monotonic_time()
      result = Row.update(row, newer_row)
      assert result.updated_at > time_before
      assert result.updated_at < System.monotonic_time()
      assert result.heartbeat_num == newer_row.heartbeat_num
    end
  end
end
