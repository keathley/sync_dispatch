defmodule SyncDispatchTest do
  use ExUnit.Case
  doctest SyncDispatch

  setup do
    SyncDispatch.HandlerTable.delete_all()

    :ok
  end

  test "dispatches events" do
    us = self()
    SyncDispatch.attach("handler-one", [:event, :prefix], fn event, data, config ->
      send(us, {:first, event, data, config})
    end)
    SyncDispatch.attach("handler-two", [:event, :prefix], fn event, data, config ->
      send(us, {:second, event, data, config})
    end, :two)

    SyncDispatch.execute([:event, :prefix], %{test: true})

    assert_receive {:first, event, data, config}
    assert event == [:event, :prefix]
    assert data == %{test: true}
    assert config == nil

    assert_receive {:second, event, data, config}
    assert event == [:event, :prefix]
    assert data == %{test: true}
    assert config == :two
  end

  test "re-using event ids produces an error" do
    assert :ok = SyncDispatch.attach("handler", [:event, :prefix], fn _, _, _ -> nil end)
    assert {:error, error} = SyncDispatch.attach("handler", [:event, :prefix], fn _, _, _ -> nil end)
    assert match?(%SyncDispatch.AttachError{}, error)
  end
end
