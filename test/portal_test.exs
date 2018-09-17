defmodule PortalTest do
  use ExUnit.Case, async: false
  alias Portal.Door

  @moduletag :capture_log

  setup do
    Application.stop(:portal)
    :ok = Application.start(:portal)
  end

  setup do
    {:ok, _left} = Portal.shoot(:green)
    {:ok, _right} = Portal.shoot(:blue)

    portal = Portal.transfer(:green, :blue, [1, 2, 3])

    {:ok, portal: portal, left: :green, right: :blue}
  end

  test "#push_right", %{portal: portal, left: left, right: right} do
    Portal.push_right(portal)

    assert Door.get(left) == [2, 3]
    assert Door.get(right) == [1]
  end

  test "#push_left", %{portal: portal, left: left, right: right} do
    Portal.push_left(portal)

    assert Door.get(left) == [1, 2, 3]
    assert Door.get(right) == []
  end
end
