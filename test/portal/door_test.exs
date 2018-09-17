defmodule Portal.DoorTest do
  use ExUnit.Case
  alias Portal.Door

  @moduletag :capture_log

  setup do
    Application.stop(:portal)
    :ok = Application.start(:portal)
  end

  setup do
    {:ok, door} = Door.start_link(:red)

    {:ok, door: door}
  end

  test "push item, get correct state and pop item", %{door: door} do
    Door.push(door, 1)
    assert Door.get(door) == [1]
    assert Door.pop(door) == {:ok, 1}
    assert Door.get(door) == []
  end

  test "set correctly state for existing door", %{door: door} do
    Door.push(door, 1)
    Door.set(door, [2])
    assert Door.get(door) == [2]
  end
end

