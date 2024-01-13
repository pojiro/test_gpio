defmodule TestGpio.GpioServer do
  use GenServer

  require Logger

  def start_link(args) when is_list(args) do
    GenServer.start_link(__MODULE__, args)
  end

  @impl true
  def init(args) when is_list(args) do
    Logger.info("|=====> Starting #{__MODULE__} GenServer")
    send(self(), :open)

    {:ok, %{pin: args[:pin], ref: nil}}
  end

  @impl true
  def terminate(reason, _state) do
    Logger.error("|=====> Stopping #{__MODULE__} GenServer, reason: #{inspect(reason)}")
  end

  @impl true
  def handle_info(:open, state) do
    {:ok, ref} =
      Circuits.GPIO.open(state.pin, :input)
      |> tap(&Logger.info("#{inspect(&1)}, #{inspect(state)}"))

    {:noreply, %{state | ref: ref}}
  end
end
