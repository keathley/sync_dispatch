defmodule SyncDispatch do
  @moduledoc """
  SyncDispatch provides an api for event driven handlers. Each event handler
  is synchronously executed in the calling process. Each function is executed
  """
  alias SyncDispatch.HandlerTable

  def execute(event, data) do
    handlers = HandlerTable.handlers_for_event(event)

    for {handler, event, config} <- handlers do
      handler.(event, data, config)
    end
  end

  def attach(id, event, fun, config \\ nil) do
    HandlerTable.insert(id, event, fun, config)
  end
end
