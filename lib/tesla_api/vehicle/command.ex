defmodule TeslaApi.Vehicle.Command do
  import TeslaApi

  alias TeslaApi.{Result, Error, Auth, Vehicle}
  alias Tesla.Env

  @doc """
  Wakes the vehicle asynchronously. Expected to wait a few seconds to a few minutes before other
  commands will begin to work. A status of `"online"` is necessary before any commands will work.
  """
  @spec wake_up(Auth.t(), Vehicle.id()) :: Vehicle.t() | Error.t()
  def wake_up(%Auth{token: token}, id) do
    request(:post, "/api/1/vehicles/#{id}/wake_up", token)
    |> Vehicle.result()
  end

  @doc """
  Honks the horn.
  """
  @spec honk_horn(Auth.t(), Vehicle.id()) :: :ok | {:error, Error.t()}
  def honk_horn(%Auth{token: token}, id) do
    request(:post, "/api/1/vehicles/#{id}/command/honk_horn", token)
    |> result()
  end

  @doc """
  Flashes the lights.
  """
  @spec flash_lights(Auth.t(), Vehicle.id()) :: :ok | {:error, Error.t()}
  def flash_lights(%Auth{token: token}, id) do
    request(:post, "/api/1/vehicles/#{id}/command/flash_lights", token)
    |> result()
  end

  @doc """
  Enables remote start. Password for the account is required.
  """
  @spec remote_start(Auth.t(), Vehicle.id(), String.t()) :: :ok | {:error, Error.t()}
  def remote_start(%Auth{token: token}, id, password) do
    request(:post, "/api/1/vehicles/#{id}/command/remote_start_drive", token, password: password)
    |> result()
  end

  @doc """
  Sets the maximum speed limit for the vehicle.
  """
  @spec set_speed_limit(Auth.t(), Vehicle.id(), non_neg_integer()) :: :ok | {:error, Error.t()}
  def set_speed_limit(%Auth{token: token}, id, limit_mph) do
    request(:post, "/api/1/vehicles/#{id}/command/speed_limit_set_limit", token,
      limit_mph: limit_mph
    )
    |> result()
  end

  @doc """
  Activates the maximum speed limit setting for the vehicle.
  """
  @spec speed_limit_activate(Auth.t(), Vehicle.id(), String.t()) :: :ok | {:error, Error.t()}
  def speed_limit_activate(%Auth{token: token}, id, pin) do
    request(:post, "/api/1/vehicles/#{id}/command/speed_limit_activate", token, pin: pin)
    |> result()
  end

  @doc """
  Deactivates the maximum speed limit setting for the vehicle.
  """
  @spec speed_limit_deactivate(Auth.t(), Vehicle.id(), String.t()) :: :ok | {:error, Error.t()}
  def speed_limit_deactivate(%Auth{token: token}, id, pin) do
    request(:post, "/api/1/vehicles/#{id}/command/speed_limit_deactivate", token, pin: pin)
    |> result()
  end

  @doc """
  Clears the pin required to activate the speed limit maximum.
  """
  @spec speed_limit_clear_pin(Auth.t(), Vehicle.id(), String.t()) :: :ok | {:error, Error.t()}
  def speed_limit_clear_pin(%Auth{token: token}, id, pin) do
    request(:post, "/api/1/vehicles/#{id}/command/speed_limit_clear_pin", token, pin: pin)
    |> result()
  end

  @doc """
  Turns on valet mode.
  """
  @spec valet_activate(Auth.t(), Vehicle.id(), String.t() | nil) :: :ok | {:error, Error.t()}
  def valet_activate(%Auth{token: token}, id, pin \\ nil) do
    request(:post, "/api/1/vehicles/#{id}/command/set_valet_mode", token, on: true, password: pin)
    |> result()
  end

  @doc """
  Turns off valet mode.
  """
  @spec valet_deactivate(Auth.t(), Vehicle.id(), String.t()) :: :ok | {:error, Error.t()}
  def valet_deactivate(%Auth{token: token}, id, pin) do
    request(:post, "/api/1/vehicles/#{id}/command/set_valet_mode", token, on: false, password: pin)
    |> result()
  end

  @doc """
  Clears the valet mode pin.
  """
  @spec valet_reset_pin(Auth.t(), Vehicle.id()) :: :ok | {:error, Error.t()}
  def valet_reset_pin(%Auth{token: token}, id) do
    request(:post, "/api/1/vehicles/#{id}/command/reset_valet_pin", token)
    |> result()
  end

  @doc """
  Turns sentry mode on or off.
  """
  @spec set_sentry_mode(Auth.t(), Vehicle.id(), bool()) :: :ok | {:error, Error.t()}
  def set_sentry_mode(%Auth{token: token}, id, on) when is_boolean(on) do
    request(:post, "/api/1/vehicles/#{id}/command/set_sentry_mode", token, on: on)
    |> result()
  end

  @doc """
  Unlocks the doors.
  """
  @spec unlock(Auth.t(), Vehicle.id()) :: :ok | {:error, Error.t()}
  def unlock(%Auth{token: token}, id) do
    request(:post, "/api/1/vehicles/#{id}/command/door_unlock", token)
    |> result()
  end

  @doc """
  Locks the doors.
  """
  @spec lock(Auth.t(), Vehicle.id()) :: :ok | {:error, Error.t()}
  def lock(%Auth{token: token}, id) do
    request(:post, "/api/1/vehicles/#{id}/command/door_lock", token)
    |> result()
  end

  @doc """
  Opens the rear trunk.
  """
  @spec trunk(Auth.t(), Vehicle.id()) :: :ok | {:error, Error.t()}
  def trunk(%Auth{token: token}, id) do
    request(:post, "/api/1/vehicles/#{id}/command/actuate_trunk", token, which_trunk: "rear")
    |> result()
  end

  @doc """
  Opens the frunk (in the front).
  """
  @spec frunk(Auth.t(), Vehicle.id()) :: :ok | {:error, Error.t()}
  def frunk(%Auth{token: token}, id) do
    request(:post, "/api/1/vehicles/#{id}/command/actuate_trunk", token, which_trunk: "front")
    |> result()
  end

  @doc """
  Vents the sunroof open (if applicable).
  """
  @spec sunroof_vent(Auth.t(), Vehicle.id()) :: :ok | {:error, Error.t()}
  def sunroof_vent(%Auth{token: token}, id) do
    request(:post, "/api/1/vehicles/#{id}/command/sun_roof_control", token, state: "vent")
    |> result()
  end

  @doc """
  Closes the sunroof (if applicable).
  """
  @spec sunroof_close(Auth.t(), Vehicle.id()) :: :ok | {:error, Error.t()}
  def sunroof_close(%Auth{token: token}, id) do
    request(:post, "/api/1/vehicles/#{id}/command/sun_roof_control", token, state: "close")
    |> result()
  end

  @doc """
  Opens the charger port.
  """
  @spec charge_port_open(Auth.t(), Vehicle.id()) :: :ok | {:error, Error.t()}
  def charge_port_open(%Auth{token: token}, id) do
    request(:post, "/api/1/vehicles/#{id}/command/charge_port_door_open", token)
    |> result()
  end

  @doc """
  Close the charge port.
  """
  @spec charge_port_close(Auth.t(), Vehicle.id()) :: :ok | {:error, Error.t()}
  def charge_port_close(%Auth{token: token}, id) do
    request(:post, "/api/1/vehicles/#{id}/command/charge_port_door_close", token)
    |> result()
  end

  @doc """
  Start charging the vehicle.
  """
  @spec charge_start(Auth.t(), Vehicle.id()) :: :ok | {:error, Error.t()}
  def charge_start(%Auth{token: token}, id) do
    request(:post, "/api/1/vehicles/#{id}/command/charge_start", token)
    |> result()
  end

  @doc """
  Stop charging the vehicle.
  """
  @spec charge_stop(Auth.t(), Vehicle.id()) :: :ok | {:error, Error.t()}
  def charge_stop(%Auth{token: token}, id) do
    request(:post, "/api/1/vehicles/#{id}/command/charge_stop", token)
    |> result()
  end

  @doc """
  Charge to the standard daily setting.
  """
  @spec charge_standard(Auth.t(), Vehicle.id()) :: :ok | {:error, Error.t()}
  def charge_standard(%Auth{token: token}, id) do
    request(:post, "/api/1/vehicles/#{id}/command/charge_standard", token)
    |> result()
  end

  @doc """
  Charge to a full battery.
  """
  @spec charge_max(Auth.t(), Vehicle.id()) :: :ok | {:error, Error.t()}
  def charge_max(%Auth{token: token}, id) do
    request(:post, "/api/1/vehicles/#{id}/command/charge_max_range", token)
    |> result()
  end

  @doc """
  Set the daily charge limit.
  """
  @spec set_charge_limit(Auth.t(), Vehicle.id(), non_neg_integer()) :: :ok | {:error, Error.t()}
  def set_charge_limit(%Auth{token: token}, id, percent) when is_integer(percent) do
    request(:post, "/api/1/vehicles/#{id}/command/set_charge_limit", token, percent: percent)
    |> result()
  end

  @doc """
  Turn on the climate control system.
  """
  @spec auto_conditioning_start(Auth.t(), Vehicle.id()) :: :ok | {:error, Error.t()}
  def auto_conditioning_start(%Auth{token: token}, id) do
    request(:post, "/api/1/vehicles/#{id}/command/auto_conditioning_start", token)
    |> result()
  end

  @doc """
  Turn off the climate control system.
  """
  @spec auto_conditioning_stop(Auth.t(), Vehicle.id()) :: :ok | {:error, Error.t()}
  def auto_conditioning_stop(%Auth{token: token}, id) do
    request(:post, "/api/1/vehicles/#{id}/command/auto_conditioning_stop", token)
    |> result()
  end

  @doc """
  Set the internal temperature.
  """
  @spec set_temperature(Auth.t(), Vehicle.id(), float, float) :: :ok | {:error, Error.t()}
  def set_temperature(%Auth{token: token}, id, driver_celcius, passenger_celcius)
      when is_number(driver_celcius) and is_number(passenger_celcius) do
    request(:post, "/api/1/vehicles/#{id}/command/set_temps", token, %{
      driver_temp: driver_celcius,
      passenger_temp: passenger_celcius
    })
    |> result()
  end

  @doc """
  Turn on a seat heater.
  """
  @spec seat_heater(Auth.t(), Vehicle.id(), 0..4, 0..3) :: :ok | {:error, Error.t()}
  def seat_heater(%Auth{token: token}, id, seat, level)
      when seat in 0..4 and level in 0..3 do
    request(:post, "/api/1/vehicles/#{id}/command/remote_seat_heater_request", token,
      heater: seat,
      level: level
    )
    |> result()
  end

  @doc """
  Toggle media playback.
  """
  @spec media_toggle(Auth.t(), Vehicle.id()) :: :ok | {:error, Error.t()}
  def media_toggle(%Auth{token: token}, id) do
    request(:post, "/api/1/vehicles/#{id}/command/media_toggle_playback", token)
    |> result()
  end

  @doc """
  Media next track.
  """
  @spec media_next(Auth.t(), Vehicle.id()) :: :ok | {:error, Error.t()}
  def media_next(%Auth{token: token}, id) do
    request(:post, "/api/1/vehicles/#{id}/command/media_next_track", token)
    |> result()
  end

  @doc """
  Media previous track.
  """
  @spec media_prev(Auth.t(), Vehicle.id()) :: :ok | {:error, Error.t()}
  def media_prev(%Auth{token: token}, id) do
    request(:post, "/api/1/vehicles/#{id}/command/media_prev_track", token)
    |> result()
  end

  @doc """
  Media next favorite track.
  """
  @spec media_next_fav(Auth.t(), Vehicle.id()) :: :ok | {:error, Error.t()}
  def media_next_fav(%Auth{token: token}, id) do
    request(:post, "/api/1/vehicles/#{id}/command/media_next_track_fav", token)
    |> result()
  end

  @doc """
  Media previous favorite track.
  """
  @spec media_prev_fav(Auth.t(), Vehicle.id()) :: :ok | {:error, Error.t()}
  def media_prev_fav(%Auth{token: token}, id) do
    request(:post, "/api/1/vehicles/#{id}/command/media_prev_track_fav", token)
    |> result()
  end

  @doc """
  Volume up.
  """
  @spec media_volume_up(Auth.t(), Vehicle.id()) :: :ok | {:error, Error.t()}
  def media_volume_up(%Auth{token: token}, id) do
    request(:post, "/api/1/vehicles/#{id}/command/media_volume_up", token)
    |> result()
  end

  @doc """
  Volume down.
  """
  @spec media_volume_down(Auth.t(), Vehicle.id()) :: :ok | {:error, Error.t()}
  def media_volume_down(%Auth{token: token}, id) do
    request(:post, "/api/1/vehicles/#{id}/command/media_volume_down", token)
    |> result()
  end

  @doc """
  Send an address to the navigation system.
  """
  @spec navigate_to(Auth.t(), Vehicle.id(), String.t()) :: :ok | {:error, Error.t()}
  def navigate_to(%Auth{token: token}, id, address) when is_binary(address) do
    request(:post, "/api/1/vehicles/#{id}/command/media_volume_down", token, %{
      :type => "share_ext_content_raw",
      :locale => "en-US",
      :timestamp_ms => DateTime.utc_now() |> DateTime.to_unix(),
      "value[android.intent.extra.TEXT]" => address
    })
    |> result()
  end

  @doc """
  Schedule an available software update.
  """
  @spec schedule_software_update(Auth.t(), Vehicle.id(), non_neg_integer) ::
          :ok | {:error, Error.t()}
  def schedule_software_update(%Auth{token: token}, id, seconds_until_install)
      when is_integer(seconds_until_install) do
    request(:post, "/api/1/vehicles/#{id}/command/media_volume_down", token,
      offset_sec: seconds_until_install
    )
    |> result()
  end

  @doc """
  Cancel the software update.
  """
  @spec cancel_software_update(Auth.t(), Vehicle.id()) :: :ok | {:error, Error.t()}
  def cancel_software_update(%Auth{token: token}, id) do
    request(:post, "/api/1/vehicles/#{id}/command/media_volume_down", token)
    |> result()
  end

  @doc """
  Opens the windows to vent.
  """
  @spec vent(Auth.t(), Vehicle.id()) :: :ok | {:error, Error.t()}
  def vent(%Auth{token: token}, id) do
    request(:post, "/api/1/vehicles/#{id}/command/window_control", token, %{
      command: "vent",
      lat: 0,
      long: 0
    })
    |> result()
  end

  @doc """
  Closes the windows.
  """
  @spec close_windows(Auth.t(), Vehicle.id()) :: :ok | {:error, Error.t()}
  def close_windows(%Auth{token: token}, id) do
    request(:post, "/api/1/vehicles/#{id}/command/window_control", token, %{
      command: "close",
      lat: 0,
      long: 0
    })
    |> result()
  end

  defp result(
         {:ok, %Env{status: 200, body: %{"response" => %{"reason" => "", "result" => true}}}}
       ) do
    :ok
  end

  defp result(
         {:ok, %Env{status: 200, body: %{"response" => %{"reason" => reason, "result" => false}}}}
       ) do
    {:error, %Error{error: :command_failed, message: reason}}
  end

  defp result(response) do
    Result.handle(response)
  end
end
