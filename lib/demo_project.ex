defmodule DemoProject.Input do
  use GenServer

  alias DemoProject.Stack

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %{})
  end

  @impl true
  def init(state) do
    schedule_input()

    {:ok, state}
  end

  def interpret_command(input) do
    case (String.split(input)) do
      ["push" | value] -> Stack.push(Stack, value)
      ["pop" | _value] -> Stack.pop(Stack)
      _ -> "Command not found"
    end
  end

  @impl true
  def handle_info(:input, state) do
    input = IO.read(:stdio, :line)
    interpret_command(input) |> IO.puts
    schedule_input()

    {:noreply, state}
  end

  def schedule_input do
    Process.send(self(), :input, [])
  end
end
