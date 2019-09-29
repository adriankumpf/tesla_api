defmodule TeslaApi.Vehicle.State do
  import TeslaApi

  alias TeslaApi.{Result, Error, Auth, Vehicle}

  defmodule Charge do
    defstruct [
      :charge_miles_added_rated,
      :charge_current_request,
      :charger_power,
      :managed_charging_start_time,
      :charger_phases,
      :charge_energy_added,
      :charger_voltage,
      :fast_charger_type,
      :time_to_full_charge,
      :ideal_battery_range,
      :usable_battery_level,
      :scheduled_charging_pending,
      :charger_actual_current,
      :est_battery_range,
      :charge_limit_soc_min,
      :charge_port_door_open,
      :managed_charging_active,
      :charge_limit_soc_max,
      :fast_charger_present,
      :fast_charger_brand,
      :scheduled_charging_start_time,
      :conn_charge_cable,
      :timestamp,
      :user_charge_enable_request,
      :charge_port_cold_weather_mode,
      :charge_to_max_range,
      :max_range_charge_counter,
      :charge_limit_soc_std,
      :charge_port_latch,
      :managed_charging_user_canceled,
      :charger_pilot_current,
      :trip_charging,
      :battery_range,
      :charging_state,
      :charge_rate,
      :not_enough_power_to_heat,
      :charge_limit_soc,
      :charge_enable_request,
      :charge_current_request_max,
      :battery_level,
      :charge_miles_added_ideal,
      :battery_heater_on
    ]

    @type t :: %__MODULE__{
            charge_miles_added_rated: float(),
            charge_current_request: non_neg_integer(),
            charger_power: non_neg_integer(),
            managed_charging_start_time: any(),
            charger_phases: any(),
            charge_energy_added: float(),
            charger_voltage: non_neg_integer(),
            fast_charger_type: String.t(),
            time_to_full_charge: float(),
            ideal_battery_range: float(),
            usable_battery_level: non_neg_integer(),
            scheduled_charging_pending: bool(),
            charger_actual_current: non_neg_integer(),
            est_battery_range: float(),
            charge_limit_soc_min: integer(),
            charge_port_door_open: bool(),
            managed_charging_active: bool(),
            charge_limit_soc_max: integer(),
            fast_charger_present: bool(),
            fast_charger_brand: String.t(),
            scheduled_charging_start_time: any(),
            conn_charge_cable: String.t(),
            timestamp: non_neg_integer(),
            user_charge_enable_request: any(),
            charge_port_cold_weather_mode: bool(),
            charge_to_max_range: bool(),
            max_range_charge_counter: non_neg_integer(),
            charge_limit_soc_std: integer(),
            charge_port_latch: String.t(),
            managed_charging_user_canceled: bool(),
            charger_pilot_current: non_neg_integer(),
            trip_charging: bool(),
            battery_range: float(),
            charging_state: String.t(),
            charge_rate: float(),
            not_enough_power_to_heat: any(),
            charge_limit_soc: integer(),
            charge_enable_request: bool(),
            charge_current_request_max: non_neg_integer(),
            battery_level: integer(),
            charge_miles_added_ideal: float(),
            battery_heater_on: bool()
          }

    @doc false
    def charge_result(charge) when is_map(charge) do
      %__MODULE__{
        charge_miles_added_rated: charge["charge_miles_added_rated"],
        charge_current_request: charge["charge_current_request"],
        charger_power: charge["charger_power"],
        managed_charging_start_time: charge["managed_charging_start_time"],
        charger_phases: charge["charger_phases"],
        charge_energy_added: charge["charge_energy_added"],
        charger_voltage: charge["charger_voltage"],
        fast_charger_type: charge["fast_charger_type"],
        time_to_full_charge: charge["time_to_full_charge"],
        ideal_battery_range: charge["ideal_battery_range"],
        usable_battery_level: charge["usable_battery_level"],
        scheduled_charging_pending: charge["scheduled_charging_pending"],
        charger_actual_current: charge["charger_actual_current"],
        est_battery_range: charge["est_battery_range"],
        charge_limit_soc_min: charge["charge_limit_soc_min"],
        charge_port_door_open: charge["charge_port_door_open"],
        managed_charging_active: charge["managed_charging_active"],
        charge_limit_soc_max: charge["charge_limit_soc_max"],
        fast_charger_present: charge["fast_charger_present"],
        fast_charger_brand: charge["fast_charger_brand"],
        scheduled_charging_start_time: charge["scheduled_charging_start_time"],
        conn_charge_cable: charge["conn_charge_cable"],
        timestamp: charge["timestamp"],
        user_charge_enable_request: charge["user_charge_enable_request"],
        charge_port_cold_weather_mode: charge["charge_port_cold_weather_mode"],
        charge_to_max_range: charge["charge_to_max_range"],
        max_range_charge_counter: charge["max_range_charge_counter"],
        charge_limit_soc_std: charge["charge_limit_soc_std"],
        charge_port_latch: charge["charge_port_latch"],
        managed_charging_user_canceled: charge["managed_charging_user_canceled"],
        charger_pilot_current: charge["charger_pilot_current"],
        trip_charging: charge["trip_charging"],
        battery_range: charge["battery_range"],
        charging_state: charge["charging_state"],
        charge_rate: charge["charge_rate"],
        not_enough_power_to_heat: charge["not_enough_power_to_heat"],
        charge_limit_soc: charge["charge_limit_soc"],
        charge_enable_request: charge["charge_enable_request"],
        charge_current_request_max: charge["charge_current_request_max"],
        battery_level: charge["battery_level"],
        charge_miles_added_ideal: charge["charge_miles_added_ideal"],
        battery_heater_on: charge["battery_heater_on"]
      }
    end
  end

  @doc """
  Fetches the charge state of the vehicle.
  """
  @spec charge_state(Auth.t(), Vehicle.id()) :: {:ok, Charge.t()} | {:error, Error.t()}
  def charge_state(%Auth{token: token}, id) do
    request(:get, "/api/1/vehicles/#{id}/data_request/charge_state", token)
    |> Result.handle(&Charge.charge_result/1)
  end

  defmodule Climate do
    defstruct [
      :battery_heater,
      :battery_heater_no_power,
      :driver_temp_setting,
      :fan_status,
      :inside_temp,
      :is_auto_conditioning_on,
      :is_climate_on,
      :is_front_defroster_on,
      :is_preconditioning,
      :is_rear_defroster_on,
      :left_temp_direction,
      :max_avail_temp,
      :min_avail_temp,
      :outside_temp,
      :passenger_temp_setting,
      :remote_heater_control_enabled,
      :right_temp_direction,
      :seat_heater_left,
      :seat_heater_rear_center,
      :seat_heater_rear_left,
      :seat_heater_rear_right,
      :seat_heater_right,
      :side_mirror_heaters,
      :smart_preconditioning,
      :timestamp,
      :wiper_blade_heater
    ]

    @type t :: %__MODULE__{
            battery_heater: bool(),
            battery_heater_no_power: any(),
            driver_temp_setting: float(),
            fan_status: non_neg_integer(),
            inside_temp: float(),
            is_auto_conditioning_on: bool(),
            is_climate_on: bool(),
            is_front_defroster_on: bool(),
            is_preconditioning: bool(),
            is_rear_defroster_on: bool(),
            left_temp_direction: non_neg_integer(),
            max_avail_temp: float(),
            min_avail_temp: float(),
            outside_temp: float(),
            passenger_temp_setting: float(),
            remote_heater_control_enabled: bool(),
            right_temp_direction: non_neg_integer(),
            seat_heater_left: non_neg_integer(),
            seat_heater_rear_center: non_neg_integer(),
            seat_heater_rear_left: non_neg_integer(),
            seat_heater_rear_right: non_neg_integer(),
            seat_heater_right: non_neg_integer(),
            side_mirror_heaters: bool(),
            smart_preconditioning: bool(),
            timestamp: non_neg_integer(),
            wiper_blade_heater: bool()
          }

    @doc false
    def climate_result(climate) when is_map(climate) do
      %__MODULE__{
        battery_heater: climate["battery_heater"],
        battery_heater_no_power: climate["battery_heater_no_power"],
        driver_temp_setting: climate["driver_temp_setting"],
        fan_status: climate["fan_status"],
        inside_temp: climate["inside_temp"],
        is_auto_conditioning_on: climate["is_auto_conditioning_on"],
        is_climate_on: climate["is_climate_on"],
        is_front_defroster_on: climate["is_front_defroster_on"],
        is_preconditioning: climate["is_preconditioning"],
        is_rear_defroster_on: climate["is_rear_defroster_on"],
        left_temp_direction: climate["left_temp_direction"],
        max_avail_temp: climate["max_avail_temp"],
        min_avail_temp: climate["min_avail_temp"],
        outside_temp: climate["outside_temp"],
        passenger_temp_setting: climate["passenger_temp_setting"],
        remote_heater_control_enabled: climate["remote_heater_control_enabled"],
        right_temp_direction: climate["right_temp_direction"],
        seat_heater_left: climate["seat_heater_left"],
        seat_heater_rear_center: climate["seat_heater_rear_center"],
        seat_heater_rear_left: climate["seat_heater_rear_left"],
        seat_heater_rear_right: climate["seat_heater_rear_right"],
        seat_heater_right: climate["seat_heater_right"],
        side_mirror_heaters: climate["side_mirror_heaters"],
        smart_preconditioning: climate["smart_preconditioning"],
        timestamp: climate["timestamp"],
        wiper_blade_heater: climate["wiper_blade_heater"]
      }
    end
  end

  @doc """
  Fetches the climate state of the vehicle.
  """
  @spec climate_state(Auth.t(), Vehicle.id()) :: {:ok, Climate.t()} | {:error, Error.t()}
  def climate_state(%Auth{token: token}, id) do
    request(:get, "/api/1/vehicles/#{id}/data_request/climate_state", token)
    |> Result.handle(&Climate.climate_result/1)
  end

  defmodule Drive do
    defstruct [
      :gps_as_of,
      :heading,
      :latitude,
      :longitude,
      :native_latitude,
      :native_location_supported,
      :native_longitude,
      :native_type,
      :power,
      :shift_state,
      :speed,
      :timestamp
    ]

    @type t :: %__MODULE__{
            gps_as_of: non_neg_integer(),
            heading: integer(),
            latitude: float(),
            longitude: float(),
            native_latitude: integer(),
            native_location_supported: integer(),
            native_longitude: float(),
            native_type: String.t(),
            power: non_neg_integer(),
            shift_state: any(),
            speed: integer(),
            timestamp: integer()
          }

    @doc false
    def drive_result(drive) when is_map(drive) do
      %__MODULE__{
        gps_as_of: drive["gps_as_of"],
        heading: drive["heading"],
        latitude: drive["latitude"],
        longitude: drive["longitude"],
        native_latitude: drive["native_latitude"],
        native_location_supported: drive["native_location_supported"],
        native_longitude: drive["native_longitude"],
        native_type: drive["native_type"],
        power: drive["power"],
        shift_state: drive["shift_state"],
        speed: drive["speed"],
        timestamp: drive["timestamp"]
      }
    end
  end

  @doc """
  Fetches the drive state of the vehicle.
  """
  @spec drive_state(Auth.t(), Vehicle.id()) :: {:ok, Drive.t()} | {:error, Error.t()}
  def drive_state(%Auth{token: token}, id) do
    request(:get, "/api/1/vehicles/#{id}/data_request/drive_state", token)
    |> Result.handle(&Drive.drive_result/1)
  end

  defmodule Gui do
    defstruct [
      :gui_24_hour_time,
      :gui_charge_rate_units,
      :gui_distance_units,
      :gui_range_display,
      :gui_temperature_units,
      :timestamp
    ]

    @type t :: %__MODULE__{
            gui_24_hour_time: bool(),
            gui_charge_rate_units: String.t(),
            gui_distance_units: String.t(),
            gui_range_display: String.t(),
            gui_temperature_units: String.t(),
            timestamp: non_neg_integer()
          }

    @doc false
    def gui_result(gui) when is_map(gui) do
      %__MODULE__{
        gui_24_hour_time: gui["gui_24_hour_time"],
        gui_charge_rate_units: gui["gui_charge_rate_units"],
        gui_distance_units: gui["gui_distance_units"],
        gui_range_display: gui["gui_range_display"],
        gui_temperature_units: gui["gui_temperature_units"],
        timestamp: gui["timestamp"]
      }
    end
  end

  @doc """
  Fetches the GUI settings of the vehicle.
  """
  @spec gui_settings(Auth.t(), Vehicle.id()) :: {:ok, Gui.t()} | {:error, Error.t()}
  def gui_settings(%Auth{token: token}, id) do
    request(:get, "/api/1/vehicles/#{id}/data_request/gui_state", token)
    |> Result.handle(&Gui.gui_result/1)
  end

  defmodule VehicleConfig do
    defstruct [
      :can_accept_navigation_requests,
      :can_actuate_trunks,
      :car_special_type,
      :car_type,
      :charge_port_type,
      :eu_vehicle,
      :exterior_color,
      :has_air_suspension,
      :has_ludicrous_mode,
      :key_version,
      :motorized_charge_port,
      :perf_config,
      :plg,
      :rear_seat_heaters,
      :rear_seat_type,
      :rhd,
      :roof_color,
      :seat_type,
      :spoiler_type,
      :sun_roof_installed,
      :third_row_seats,
      :timestamp,
      :trim_badging,
      :wheel_type
    ]

    @type t :: %__MODULE__{
            can_accept_navigation_requests: bool(),
            can_actuate_trunks: bool(),
            car_special_type: String.t(),
            car_type: String.t(),
            charge_port_type: String.t(),
            eu_vehicle: bool(),
            exterior_color: String.t(),
            has_air_suspension: bool(),
            has_ludicrous_mode: bool(),
            key_version: integer(),
            motorized_charge_port: bool(),
            perf_config: String.t(),
            plg: any(),
            rear_seat_heaters: integer(),
            rear_seat_type: any(),
            rhd: bool(),
            roof_color: String.t(),
            seat_type: any(),
            spoiler_type: String.t(),
            sun_roof_installed: any(),
            third_row_seats: String.t(),
            timestamp: non_neg_integer(),
            trim_badging: String.t(),
            wheel_type: String.t()
          }

    @doc false
    def vehicle_config_result(vehicle_config) when is_map(vehicle_config) do
      %__MODULE__{
        can_accept_navigation_requests: vehicle_config["can_accept_navigation_requests"],
        can_actuate_trunks: vehicle_config["can_actuate_trunks"],
        car_special_type: vehicle_config["car_special_type"],
        car_type: vehicle_config["car_type"],
        charge_port_type: vehicle_config["charge_port_type"],
        eu_vehicle: vehicle_config["eu_vehicle"],
        exterior_color: vehicle_config["exterior_color"],
        has_air_suspension: vehicle_config["has_air_suspension"],
        has_ludicrous_mode: vehicle_config["has_ludicrous_mode"],
        key_version: vehicle_config["key_version"],
        motorized_charge_port: vehicle_config["motorized_charge_port"],
        perf_config: vehicle_config["perf_config"],
        plg: vehicle_config["plg"],
        rear_seat_heaters: vehicle_config["rear_seat_heaters"],
        rear_seat_type: vehicle_config["rear_seat_type"],
        rhd: vehicle_config["rhd"],
        roof_color: vehicle_config["roof_color"],
        seat_type: vehicle_config["seat_type"],
        spoiler_type: vehicle_config["spoiler_type"],
        sun_roof_installed: vehicle_config["sun_roof_installed"],
        third_row_seats: vehicle_config["third_row_seats"],
        timestamp: vehicle_config["timestamp"],
        trim_badging: vehicle_config["trim_badging"],
        wheel_type: vehicle_config["wheel_type"]
      }
    end
  end

  @doc """
  Fetches the vehicle config.
  """
  @spec vehicle_config(Auth.t(), Vehicle.id()) :: {:ok, VehicleConfig.t()} | {:error, Error.t()}
  def vehicle_config(%Auth{token: token}, id) do
    request(:get, "/api/1/vehicles/#{id}/data_request/vehicle_config", token)
    |> Result.handle(&VehicleConfig.vehicle_config_result/1)
  end

  defmodule VehicleState do
    defstruct [
      :api_version,
      :autopark_state_v3,
      :autopark_style,
      :calendar_supported,
      :car_version,
      :center_display_state,
      :df,
      :dr,
      :ft,
      :homelink_nearby,
      :is_user_present,
      :last_autopark_error,
      :locked,
      :media_state,
      :notifications_supported,
      :odometer,
      :parsed_calendar_supported,
      :pf,
      :pr,
      :remote_start,
      :remote_start_enabled,
      :remote_start_supported,
      :rt,
      :fd_window,
      :fp_window,
      :rd_window,
      :rp_window,
      :sentry_mode,
      :software_update,
      :speed_limit_mode,
      :sun_roof_percent_open,
      :sun_roof_state,
      :timestamp,
      :valet_mode,
      :valet_pin_needed,
      :vehicle_name
    ]

    @type t :: %__MODULE__{
            api_version: integer(),
            autopark_state_v3: String.t(),
            autopark_style: String.t(),
            calendar_supported: bool(),
            car_version: String.t(),
            center_display_state: non_neg_integer(),
            df: non_neg_integer(),
            dr: non_neg_integer(),
            ft: non_neg_integer(),
            homelink_nearby: bool(),
            is_user_present: bool(),
            last_autopark_error: String.t(),
            locked: bool(),
            media_state: MediaState.t(),
            notifications_supported: bool(),
            odometer: float(),
            parsed_calendar_supported: bool(),
            pf: non_neg_integer(),
            pr: non_neg_integer(),
            remote_start: bool(),
            remote_start_enabled: bool(),
            remote_start_supported: bool(),
            rt: non_neg_integer(),
            fd_window: 0 | 1,
            fp_window: 0 | 1,
            rd_window: 0 | 1,
            rp_window: 0 | 1,
            sentry_mode: bool(),
            software_update: SoftWareUpdate.t(),
            speed_limit_mode: SpeedLimit.t(),
            sun_roof_percent_open: any(),
            sun_roof_state: String.t(),
            timestamp: non_neg_integer(),
            valet_mode: bool(),
            valet_pin_needed: bool(),
            vehicle_name: String.t()
          }

    defmodule MediaState do
      defstruct [:remote_control_enabled]
      @type t :: %__MODULE__{remote_control_enabled: bool()}
    end

    defmodule SoftwareUpdate do
      defstruct [:expected_duration_sec, :status]
      @type t :: %__MODULE__{expected_duration_sec: non_neg_integer(), status: String.t()}
    end

    defmodule SpeedLimit do
      defstruct [:active, :current_limit_mph, :max_limit_mph, :min_limit_mph, :pin_code_set]

      @type t :: %__MODULE__{
              active: bool(),
              current_limit_mph: float(),
              max_limit_mph: non_neg_integer(),
              min_limit_mph: non_neg_integer(),
              pin_code_set: bool()
            }
    end

    @doc false
    def vehicle_state_result(vehicle_state) when is_map(vehicle_state) do
      %__MODULE__{
        api_version: vehicle_state["api_version"],
        autopark_state_v3: vehicle_state["autopark_state_v3"],
        autopark_style: vehicle_state["autopark_style"],
        calendar_supported: vehicle_state["calendar_supported"],
        car_version: vehicle_state["car_version"],
        center_display_state: vehicle_state["center_display_state"],
        df: vehicle_state["df"],
        dr: vehicle_state["dr"],
        ft: vehicle_state["ft"],
        homelink_nearby: vehicle_state["homelink_nearby"],
        is_user_present: vehicle_state["is_user_present"],
        last_autopark_error: vehicle_state["last_autopark_error"],
        locked: vehicle_state["locked"],
        media_state: %MediaState{
          remote_control_enabled: vehicle_state["media_state"]["remote_control_enabled"]
        },
        notifications_supported: vehicle_state["notifications_supported"],
        odometer: vehicle_state["odometer"],
        parsed_calendar_supported: vehicle_state["parsed_calendar_supported"],
        pf: vehicle_state["pf"],
        pr: vehicle_state["pr"],
        remote_start: vehicle_state["remote_start"],
        remote_start_enabled: vehicle_state["remote_start_enabled"],
        remote_start_supported: vehicle_state["remote_start_supported"],
        rt: vehicle_state["rt"],
        software_update: %SoftwareUpdate{
          expected_duration_sec: vehicle_state["software_update"]["expected_duration_sec"],
          status: vehicle_state["software_update"]["status"]
        },
        speed_limit_mode: %SpeedLimit{
          active: vehicle_state["speed_limit_mode"]["active"],
          current_limit_mph: vehicle_state["speed_limit_mode"]["current_limit_mph"],
          max_limit_mph: vehicle_state["speed_limit_mode"]["max_limit_mph"],
          min_limit_mph: vehicle_state["speed_limit_mode"]["min_limit_mph"],
          pin_code_set: vehicle_state["speed_limit_mode"]["pin_code_set"]
        },
        sun_roof_percent_open: vehicle_state["sun_roof_percent_open"],
        sun_roof_state: vehicle_state["sun_roof_state"],
        timestamp: vehicle_state["timestamp"],
        valet_mode: vehicle_state["valet_mode"],
        fd_window: vehicle_state["fd_window"],
        fp_window: vehicle_state["fp_window"],
        rd_window: vehicle_state["rd_window"],
        rp_window: vehicle_state["rp_window"],
        sentry_mode: vehicle_state["sentry_mode"],
        valet_pin_needed: vehicle_state["valet_pin_needed"],
        vehicle_name: vehicle_state["vehicle_name"]
      }
    end
  end

  @doc """
  Fetches the vehicle state.
  """
  @spec vehicle_state(Auth.t(), Vehicle.id()) :: {:ok, VehicleState.t()} | {:error, Error.t()}
  def vehicle_state(%Auth{token: token}, id) do
    request(:get, "/api/1/vehicles/#{id}/data_request/vehicle_state", token)
    |> Result.handle(&VehicleState.vehicle_state_result/1)
  end

  @doc """
  """
  @spec mobile_enabled?(Auth.t(), Vehicle.id()) :: {:ok, bool} | {:error, Error.t()}
  def mobile_enabled?(%Auth{token: token}, id) do
    request(:get, "/api/1/vehicles/#{id}/mobile_enabled", token)
    |> Result.handle()
  end
end
