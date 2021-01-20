# SyncDispatch

<!-- MDOC !-->

`SyncDispatch` provides an API for executing events synchronously and in-process. This is based on ideas in `:telemetry` but made slightly more general.

## Usage

Events are a list of atoms. You can attach to events like so:

```elixir
SyncDispatch.attach("handler-id", [:event, :name], &__MODULE__.handle_event/3)

def handle_event(event, data, _config) do
  # Do some stuff...
end
```

Events are executed by calling `SyncDispatch.execute/2` like so:

```elixir
SyncDispatch.execute([:event, :name], %{some: :data})
```

Any number of handlers can be attached to an event. These handlers are all executed serially and in the executing process. Thus, there is no data copying and the handlers have access to any information stored in process dictionary. The order of execution for each handler is not guaranteed.

## Errors

Errors in handlers are *not* handled for you. Any raised exceptions or thrown errors
will propagate to the executing function. This may change in the future based on usage
patterns but for now you're advised to handle errors yourself.

<!-- MDOC !-->

## Should I use this?

idk. This is mostly an experiment. But there's not much in here and it should
perform pretty well. I'm unclear if this is a good design pattern though. Event
based systems are inherently more complex than non-evented systems.
