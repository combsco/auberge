defmodule Auberge.Data do
  alias Auberge.Repo
  alias Auberge.Customer
  alias Auberge.Property
  alias Auberge.Room
  alias Auberge.RoomType
  alias Auberge.RoomRate

  def generate do
    Logger.disable(self())
    _generate()
    Logger.enable(self())
  end

  defp _generate do
    IO.puts "Generating data ..."
    # Property ... 96 Room, 6 Floor, 3 Room Layouts
    ovalii_hotel = Repo.insert!(%Property{name: "Ovalii Hotel & Suites", address: %{throughfare: "284 Race Avenue", locality: "East Stroudsburg", administrative_area: "PA", country: "US", postal_code: "18301"}})
    # Room Rate
    rack_rate = Repo.insert!(%RoomRate{description: "Rack", # Rack aka Default, Standard, etc.
                                       code: "RACK1",
                                       starts_at: Ecto.Date.cast!("2017-01-01"),
                                       ends_at: Ecto.Date.cast!("2018-01-01"),
                                       days_of_week: %{
                                         monday: true,
                                         tuesday: true,
                                         wednesday: true,
                                         thursday: true,
                                         friday: true,
                                         saturday: false,
                                         sunday: false
                                         },
                                       min_stay: 1,
                                       max_stay: 3,
                                       min_occupancy: 1,
                                       max_occupancy: 2,
                                       extra_adult_price: 99.99,
                                       extra_child_price: 0.00,
                                       price: 261.01})

    # Room Types
    guest_2_dbl = Repo.insert!(%RoomType{description: "Guest", num_of_beds: 2, type_of_beds: "Double"})
    guest_1_king = Repo.insert!(%RoomType{description: "Guest", num_of_beds: 1, type_of_beds: "King"})
    suite_1_king = Repo.insert!(%RoomType{description: "Suite", num_of_beds: 1, type_of_beds: "King"})

    # Associate Room & Types
    guest_2_dbl |> Repo.preload(:rates) |> Ecto.Changeset.change() |> Ecto.Changeset.put_assoc(:rates, [rack_rate]) |> Repo.update!
    guest_1_king |> Repo.preload(:rates) |> Ecto.Changeset.change() |> Ecto.Changeset.put_assoc(:rates, [rack_rate]) |> Repo.update!
    suite_1_king |> Repo.preload(:rates) |> Ecto.Changeset.change() |> Ecto.Changeset.put_assoc(:rates, [rack_rate]) |> Repo.update!

    # Rooms (Floor 1)
    1..16 |> Enum.each(fn x ->
                          room_type = cond do
                                        x <= 12 ->
                                          guest_2_dbl
                                        true ->
                                          guest_1_king
                                      end
                          num = x |> Integer.to_string |> String.rjust(2, ?0)
                          Repo.insert!(%Room{room_num: "1#{num}", floor_num: 1, property: ovalii_hotel, room_type: room_type})
                        end)

    # Room (Floor 2)
    1..16 |> Enum.each(fn x ->
                          room_type = cond do
                                        x <= 12 ->
                                          guest_2_dbl
                                        true ->
                                          guest_1_king
                                      end
                          num = x |> Integer.to_string |> String.rjust(2, ?0)
                          Repo.insert!(%Room{room_num: "2#{num}", floor_num: 2, property: ovalii_hotel, room_type: room_type})
                        end)

    # Room (Floor 3)
    1..16 |> Enum.each(fn x ->
                          room_type = cond do
                                        x <= 10 ->
                                          guest_2_dbl
                                        true ->
                                          guest_1_king
                                      end
                          num = x |> Integer.to_string |> String.rjust(2, ?0)
                          Repo.insert!(%Room{room_num: "3#{num}", floor_num: 3, property: ovalii_hotel, room_type: room_type})
                        end)
    # Room (Floor 4)
    1..16 |> Enum.each(fn x ->
                          room_type = cond do
                                        x <= 12 ->
                                          guest_2_dbl
                                        true ->
                                          guest_1_king
                                      end
                          num = x |> Integer.to_string |> String.rjust(2, ?0)
                          Repo.insert!(%Room{room_num: "4#{num}", floor_num: 4, property: ovalii_hotel, room_type: room_type})
                        end)
    # Room (Floor 5)
    1..16 |> Enum.each(fn x ->
                          room_type = cond do
                                        x <= 10 ->
                                          guest_2_dbl
                                        true ->
                                          guest_1_king
                                      end
                          num = x |> Integer.to_string |> String.rjust(2, ?0)
                          Repo.insert!(%Room{room_num: "5#{num}", floor_num: 5, property: ovalii_hotel, room_type: room_type})
                        end)
    # Room (Floor 6)
    1..16 |> Enum.each(fn x ->
                          room_type = cond do
                                        x <= 12 ->
                                          suite_1_king
                                        true ->
                                          guest_1_king
                                      end
                          num = x |> Integer.to_string |> String.rjust(2, ?0)
                          Repo.insert!(%Room{room_num: "6#{num}", floor_num: 6, property: ovalii_hotel, room_type: room_type})
                        end)

  end
end

Auberge.Data.generate
