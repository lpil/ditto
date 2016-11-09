defmodule PushGossip.Config do
  @moduledoc """
  ## Fields:

  - `gossip_interval`: Time interval between rounds of gossip messages being
  sent by a node.
  - `gossip_num`: The number of gossip heartbeats to send per round.
  - `fail_time`: The time of silence from a node before another node will
  consider it dead.
  - `timeout_time`: The time of silence after considering a node dead that
  records of it will be removed from the node's table.
  """
  defstruct(
    gossip_interval: 1000,
    gossip_num: 2,
    fail_time: 5000,
    timeout_time: 5000,
  )
end
