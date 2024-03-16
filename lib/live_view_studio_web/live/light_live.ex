defmodule LiveViewStudioWeb.LightLive do
  use LiveViewStudioWeb, :live_view

  # mount
  def mount(_params, _session, socket) do
    socket = assign(socket, brightness: 10)
    {:ok, socket}
  end

  # render
  def render(assigns) do
    ~H"""
    <h1>Front Porch Light</h1>
    <div id="light">
      <div class="meter">
        <span style={"width: #{@brightness}%"}>
          <%= @brightness %>%
        </span>
      </div>
      <button phx-click="off">
        <img src="/images/light-off.svg" />
      </button>
      <button phx-click="down">
        <img src="/images/down.svg" />
      </button>
      <button phx-click="up">
        <img src="/images/up.svg" />
      </button>
      <button phx-click="on">
        <img src="/images/light-on.svg" />
      </button>
      <button phx-click="random">
        <img src="/images/fire.svg" />
      </button>
    </div>
    """
  end

  # handle event
  def handle_event("on", _unsigned_params, socket) do
    socket = assign(socket, brightness: 100)

    {:noreply, socket}
  end

  def handle_event("up", _unsigned_params, socket) do
    socket = update(socket, :brightness, &(&1 + 10))

    {:noreply, socket}
  end

  def handle_event("down", _unsigned_params, socket) do
    socket = update(socket, :brightness, &(&1 - 10))

    {:noreply, socket}
  end

  def handle_event("random", _unsigned_params, socket) do
    socket = assign(socket, brightness: Enum.random(0..100))

    {:noreply, socket}
  end

  def handle_event("off", _unsigned_params, socket) do
    socket = assign(socket, brightness: 0)

    {:noreply, socket}
  end
end