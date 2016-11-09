defmodule PushGossip.MembershipTable do
  alias __MODULE__.Row

  @enforce_keys [:self, :rows]
  defstruct heartbeat_num: 0, self: nil, rows: %{}

  def new(self_id) do
    self_row = %Row{ heartbeat_num: 0, updated_at: System.monotonic_time() }
    %__MODULE__{
      self: self_id,
      rows: %{ self_id => self_row },
    }
  end
end
