# Ditto

Modeling a membership in distributed system with Erlang processes.

Only message passing is used in the model. No process links, no monitors.

## Models

### `push_gossip`

A membership system with failure detection based around push gossip. See
`apps/push_gossip` for more information.
