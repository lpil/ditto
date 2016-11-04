# Ditto

Modeling a distributed system with a gossip based membership system using Erlang
processes.

Only message passing is used in the model. No process links, no monitors.

- 100% Complete. Node failures will always be eventually detected.
- Not 100% Accurate. Alive processes may be mistakenly considered dead.


## Configuration

- `gossip_time`: Time interval between rounds of gossip messages being sent by a
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
