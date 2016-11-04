defmodule Sim.MembershipTable.Row do
  alias __MODULE__

  keys = [:heartbeat_num, :updated_at]
  @enforced_keys keys
  defstruct keys

  @type t :: %__MODULE__{ heartbeat_num: non_neg_integer(), updated_at: integer() }

  @spec update(t, t) :: t
  @doc """
  Merge a new row for a node into the existing row for that node.

  If the `heartbeat_num` of the "new" row has a lower `heartbeat_num` it is in
  fact older, and thus has no new info for us. In this case the function no-ops
  and returns the first row.
  """
  def update(%Row{ heartbeat_num: t1 } = row, %Row{ heartbeat_num: t2 })
  when t1 > t2 do
    row
  end

  def update(%Row{}, %Row{ heartbeat_num: n }) do
    %Row{ heartbeat_num: n, updated_at: System.monotonic_time }
  end
end
