defmodule Sim.MembershipTable.Row do
  alias __MODULE__

  keys = [:heartbeat_num, :updated_at]
  @enforced_keys keys
  defstruct keys

  @doc """
  Merge a new row for a node into the existing row for that node.

  If the `heartbeat_num` of the new row it has no new info, so this
  function noops.
  """
  def update(%Row{ heartbeat_num: t1 } = row, %Row{ heartbeat_num: t2 })
  when t1 > t2 do
    row
  end

  def update(_, %Row{ heartbeat_num: n }) do
    %Row{ heartbeat_num: n, updated_at: System.monotonic_time }
  end
end
