defmodule Portal.Door do
  @moduledoc """
  Basic functions for manage state in Door.
  """

  use Agent

  @doc """
  Create a new door with given name. Initial state of
  door is blank list [].

  ## Example
      iex> Portal.Door.start_link(:door)
      {:ok, pid}
  """
  @spec start_link(atom) :: Agent.on_start()
  def start_link(door) do
    Agent.start_link(fn -> [] end, name: door)
  end

  @doc """
  Push given item into door's state. This operation is async.

  ## Example
      iex> Portal.Door.push(:door, 2)
      :ok
  """
  @spec push(atom(), any()) :: :ok
  def push(door, item) do
    Agent.update(door, fn list -> [item|list] end)
  end

  @doc """
  Take an item from head of state.

  ## Example
      iex> Portal.Door.pop(:door)
      1
  """
  @spec pop(atom()) :: :error | {:ok, any()}
  def pop(door) do
    Agent.get_and_update(door, fn
      [] -> {:error, []}
      [h|t] -> {{:ok, h}, t}
    end)
  end

  @doc """
  Get a state from Door.

  ## Example
      iex> Portal.Door.get(:door)
      [1, 2, 3]
  """
  @spec get(atom()) :: list()
  def get(door) do
    Agent.get(door, fn list -> list end)
  end

  @doc """
  Set state for given Door.

  ## Example
      iex> Portal.Door.set(:door, [5, 6, 7])
      [5, 6, 7]
  """
  @spec set(atom(), list()) :: list()
  def set(door, list) do
    Agent.update(door, fn _list -> list end)
  end
end
