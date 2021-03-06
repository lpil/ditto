defmodule PushGossip.MembershipTable do
  alias __MODULE__.Row

  @enforce_keys [:self, :rows]
  defstruct heartbeat_num: 0, self: nil, rows: %{}

  @type node_id :: any
  @type t :: %__MODULE__{heartbeat_num: non_neg_integer,
                         rows: %{optional(node_id) => Row.t},
                         self: node_id}

  @spec new(node_id) :: t
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


  @spec update_self(t) :: t
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


  @spec random_row(t) :: {:ok, node_id, Row.t} | :no_rows
  @doc """
  Select a random non-self row from the table.
  """
  def random_row(table = %__MODULE__{}) do
    try do
      {id, row} = table.rows |> Map.delete(table.self) |> Enum.random()
      {:ok, id, row}
    rescue
      _ in Enum.EmptyError -> :no_rows
    end
  end
end
