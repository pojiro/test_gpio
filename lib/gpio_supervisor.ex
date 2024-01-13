defmodule TestGpio.GpioSupervisor do
  use Supervisor

  def start_link(args) do
    Supervisor.start_link(__MODULE__, args)
  end

  @impl true
  def init(_args) do
    children =
      Enum.map(
        # [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27],
        [5, 6, 13, 19, 26],
        fn pin ->
          Supervisor.child_spec(
            {TestGpio.GpioServer, [pin: pin]},
            id: pin
          )
        end
      )

    Supervisor.init(children, strategy: :one_for_one)
  end
end
