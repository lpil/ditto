defmodule PushGossip.MembershipTable do
  alias __MODULE__.Row

  @enforce_keys [:self, :rows]
  defstruct heartbeat_num: 0, self: nil, rows: %{}

  @doc """
  Construct a new MembershipTable with a prepopulated row for self.
  """
  def new(self_id) do
    self_row = %Row{ heartbeat_num: 0, updated_at: System.monotonic_time() }
    %__MODULE__{
      self: self_id,
      rows: %{ self_id => self_row },
    }
  end


  @doc """
  Construct a new MembershipTable with a prepopulated row for self.
  """
  def update_self(table = %__MODULE__{}) do
    now = System.monotonic_time()
    self = table.rows[table.self]
    self = %Row{self | heartbeat_num: self.heartbeat_num + 1, updated_at: now}
    rows = %{table.rows | table.self => self}
    %__MODULE__{table | heartbeat_num: self.heartbeat_num, rows: rows}
  end
end
