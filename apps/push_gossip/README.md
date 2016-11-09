# Ditto: PushGossip

The application that models a distributed system with gossip based failure detection.

No bandwidth limits are assumed, so nodes can send their entire membership table
as gossip.

Messages are regular Erlang process messages, currently no additional chance of
message loss is applied.

- 100% Complete. Node failures will always be eventually detected.
- Not 100% Accurate. Alive processes may be mistakenly considered dead.


## Configuration

- `gossip_interval`: Time interval between rounds of gossip messages being sent by a
  node.
- `gossip_num`: The number of gossip heartbeats to send per round.
- `fail_time`: The time of silence from a node before another node will consider
  it dead.
- `timeout_time`: The time of silence after considering a node dead that records
  of it will be removed from the node's table.


## References

- University of Illinois' "Cloud Computing Concepts" Coursera lecture on gossip
  style membership [[link]][cc-lecture]

[cc-lecture]: https://www.coursera.org/learn/cloud-computing/lecture/iisnX/2-3-gossip-style-membership
