defmodule LiveViewStudioWeb.LightLive do
  use LiveViewStudioWeb, :live_view

  # mount
  def mount(_params, _session, socket) do
    socket = assign(socket, brightness: 10, temp: "3000")
    {:ok, socket}
  end

  # render
  def render(assigns) do
    ~H"""
    <h1>Front Porch Light</h1>
    <div id="light">
      <div class="meter">
      <span style={"width: #{@brightness}%; background: #{temp_color(@temp)}"}>
          <%= @brightness %>%
        </span>
        </div>
        <form phx-change="update">
          <input type="range" min="0" max="100"
              name="brightness" value={"#{@brightness}"} />
        </form>
        <form phx-change="change-temp">
        <div class="temps">
          <%= for temp <- ["3000", "4000", "5000"] do %>
            <div>
              <input type="radio" id={temp} name="temp" value={temp} checked={temp == @temp} />
              <label for={temp}><%= temp %></label>
            </div>
          <% end %>
        </div>
      </form>
      <button phx-click="off">
        <img src="/images/light-off.svg" />
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

  def handle_event("update", %{"brightness" => brightness}, socket) do
    {:noreply, assign(socket, brightness: String.to_integer(brightness))}
  end

  def handle_event("random", _unsigned_params, socket) do
    socket = assign(socket, brightness: Enum.random(0..100))

    {:noreply, socket}
  end

  def handle_event("off", _unsigned_params, socket) do
    socket = assign(socket, brightness: 0)

    {:noreply, socket}
  end

  def handle_event("change-temp", %{"temp" => temp}, socket) do
    socket = assign(socket, temp: temp)
    {:noreply, socket}
  end

  defp temp_color("3000"), do: "#F1C40D"
  defp temp_color("4000"), do: "#FEFF66"
  defp temp_color("5000"), do: "#99CCFF"
end
