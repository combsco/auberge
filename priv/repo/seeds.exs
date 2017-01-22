defmodule Auberge.Data do
  alias Auberge.Repo
  alias Auberge.Customer
  alias Auberge.Property
  alias Auberge.Room
  alias Auberge.RoomType
  alias Auberge.RoomRate
  alias Auberge.Address

  def generate do
    Logger.disable(self())
    _generate()
    Logger.enable(self())
  end

  defp _generate do
    IO.puts "Generating data ..."
    # Customers
    Repo.insert!(%Customer{first_name: "Rose",
                         last_name: "Gutierrez",
                         phone_num: "17575466291",
                         email: "rgutierrez0@com.com",
                         address: [%Address{type: "Mailing",
                                     throughfare: "6305 Service Center",
                                     locality: "Hampton",
                                     administrative_area: "Virginia",
                                     country: "US",
                                     postal_code: "23668"},
                                   %Address{type: "Billing",
                                     throughfare: "6 Swallow Place",
                                     locality: "Bakersfield",
                                     administrative_area: "California",
                                     country: "US",
                                     postal_code: "93305"}]})

    Repo.insert!(%Customer{first_name: "Denise",
                         last_name: "Perez",
                         phone_num: "13376804000",
                         email: "dperez2@census.gov",
                         address: [%Address{type: "Mailing",
                                    throughfare: "58 Blue Bill Park Drive",
                                    locality: "Lafayette",
                                    administrative_area: "Louisiana",
                                    country: "US",
                                    postal_code: "70593"}]})

    Repo.insert!(%Customer{first_name: "Bobby",
                         last_name: "Price",
                         phone_num: "16056676201",
                         email: "bprice4@1688.com",
                         address: [%{type: "Mailing",
                                    throughfare: "600 Bellgrove Place",
                                    locality: "Sioux Falls",
                                    administrative_area: "South Dakota",
                                    country: "US",
                                    postal_code: "57110"}]})

    Repo.insert!(%Customer{first_name: "Sara",
                          last_name: "Rogers",
                          phone_num: "309881729212",
                          email: "srogers0@opensource.org",
                          address: [%Address{type: "Mailing",
                                     throughfare: "1 Roth Way",
                                     locality: "Chaniá",
                                     administrative_area: "",
                                     country: "GR",
                                     postal_code: ""}]})

    Repo.insert!(%Customer{first_name: "Elizabeth",
                         last_name: "Montgomery",
                         phone_num: "626024327306",
                         email: "emontgomery1@mapy.cz",
                         address: [%Address{type: "Mailing",
                                    throughfare: "98 Warner Junction",
                                    locality: "Pamungguan",
                                    administrative_area: "",
                                    country: "ID",
                                    postal_code: ""}]})



    # Property ... 96 Room, 6 Floor, 3 Room Layouts
    ovalii_hotel = Repo.insert!(%Property{name: "Ovalii Hotel & Suites",
                                          address: %Address{throughfare: "284 Race Avenue",
                                                      locality: "East Stroudsburg",
                                                     administrative_area: "PA",
                                                     country: "US",
                                                     postal_code: "18301"},
                                          cancellation_time: "18:00",
                                          reservation_cutoff: %{time: "05:00",
                                                                day: "same"},
                                          currency: "USD",
                                          tz: "America/New_York",
                                          status: "active"})
    # Room Rate
    rack_rate = Repo.insert!(%RoomRate{name: "Rack", # Rack aka Default, Standard, etc.
                                       short_code: "RACK1",
                                       type: "Standard",
                                       starts_at: Ecto.Date.cast!("2017-01-01"),
                                       ends_at: Ecto.Date.cast!("2018-01-01"),
                                       effective_days: %{
                                         monday: true,
                                         tuesday: true,
                                         wednesday: true,
                                         thursday: true,
                                         friday: true,
                                         saturday: false,
                                         sunday: false
                                         },
                                       min_stay: 1,
                                       max_stay: 7,
                                       min_occupancy: 1,
                                       max_occupancy: 2,
                                       extra_adult_price: 99.99,
                                       extra_child_price: 0.00,
                                       price: 261.01,
                                       price_model: "PerDay",
                                       status: "active"})

    # Room Types
    guest_2_dbl = Repo.insert!(%RoomType{type: "Guest",
                                         class: "Deluxe",
                                         view: "City View",
                                         max_adults: 4,
                                         max_children: 3,
                                         bedding: %{type: "Double",
                                                    quantity: 2},
                                         extra_bedding: [%{type: "Rollaway Bed",
                                                          quantity: 1,
                                                          frequency: "PerDay",
                                                          amount: 20.00}],
                                         smoking: false,
                                         status: "active"})

    guest_1_king = Repo.insert!(%RoomType{type: "Guest",
                                          class: "Standard",
                                          view: "Ocean View",
                                          max_adults: 2,
                                          max_children: 1,
                                          bedding: %{type: "Double",
                                                     quantity: 2},
                                          extra_bedding: [%{type: "Rollaway Bed",
                                                           quantity: 1,
                                                           frequency: "PerDay",
                                                           amount: 20.00}],
                                          smoking: false,
                                          status: "active"})

    suite_1_king = Repo.insert!(%RoomType{type: "Suite",
                                          class: "Suite",
                                          view: "Ocean View",
                                          max_adults: 2,
                                          max_children: 1,
                                          bedding: %{type: "King",
                                                     quantity: 1},
                                          extra_bedding: [%{type: "Rollaway Bed",
                                                           quantity: 1,
                                                           frequency: "One-time",
                                                           amount: 0.00}],
                                          smoking: false,
                                          status: "active"})

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
