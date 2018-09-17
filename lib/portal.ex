defmodule Portal do
  @moduledoc """
  This module provides functions to handle data between doors. You can
  create a door via this module, create new portal for 2 doors and
  transfer data between them.
  """

  defstruct [:left, :right]

  alias Portal.Door

  @type t :: %__MODULE__{left: atom(), right: atom()}

  @doc """
  Create a new portal which is connect 2 doors by given name (left and right) and
  assign initial data to left door.

  ## Example
      iex> Portal.transfer(:door_left, :door_right, [1, 2, 3])
      %Portal{left: :door_left, right: :door_right}
  """
  @spec transfer(atom(), atom(), list()) :: t
  def transfer(left, right, data) do
    Door.set(left, data)

    %Portal{left: left, right: right}
  end

  @doc """
  Push item from left door to right door from given portal.
  This method is async.

  ## Example
      iex> Portal.push_right(portal)
      :ok
  """
  @spec push_right(t) :: :ok
  def push_right(%Portal{left: left, right: right}) do
    case Door.pop(left) do
      :error -> :ok
      {:ok, item} -> Door.push(right, item)
    end
  end

  @doc """
  Push item from right door to left door from given portal.
  This method is async.

  ## Example
      iex> Portal.push_left(portal)
      :ok
  """
  @spec push_left(t) :: :ok
  def push_left(%Portal{left: left, right: right}) do
    case Door.pop(right) do
      :error -> :ok
      {:ok, item} -> Door.push(left, item)
    end
  end


  @doc """
  Create new Door for use it in portal. Door's name
  is uniq for entire node by atom.

  ## Example
      iex> Portal.shoot(:door_1)
      {:ok, pid}
  """
  @spec shoot(atom()) :: Agent.on_start()
  def shoot(door) do
    child_spec = %{id: Portal.Door, start: {Portal.Door, :start_link, [door]}}

    DynamicSupervisor.start_child(Portal.DynamicSupervisor, child_spec)
  end

  @doc """
  Return count of created doors.

  ## Example
      iex> Portal.count_doors
      %{active: 0, specs: 0, supervisors: 0, workers: 0}
  """
  @spec count_doors() :: map()
  def count_doors() do
    DynamicSupervisor.count_children(Portal.DynamicSupervisor)
  end
end
