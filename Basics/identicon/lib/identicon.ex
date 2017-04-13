defmodule Identicon do

  def main(input) do
   input 
   |> hash_input
   |> pick_color
   |> build_grid
   |> filter_odd_squares
   |> build_pixel_map
   |> draw_image
   |> save_image(input)
  end

  def save_image(image, input) do
    File.write("#{input}.png", image)
  end

  def draw_image(image) do
    %Identicon.Image{color: color, pixel_map: pixel_map} = image
    image = :egd.create(250, 250)
    fill = :egd.color(color)

    Enum.each(pixel_map, fn({start, stop}) -> 
      :egd.filledRectangle(image, start, stop, fill)
    end)

    :egd.render(image)
  end

  def build_pixel_map(image) do
    %Identicon.Image{grid: grid} = image
    pixel_map = Enum.map(grid, fn({_code, index}) -> 
      horizontal = rem(index, 5) * 50
      vertical = div(index, 5) * 50
      top_left = {horizontal, vertical}
      bottom_right = {horizontal + 50, vertical + 50}
      {top_left, bottom_right}
    end)
    %Identicon.Image{image | pixel_map: pixel_map}
  end

  def filter_odd_squares(image) do
    %Identicon.Image{grid: grid} = image
    grid = Enum.filter(grid, fn({code, _index}) -> 
      # rem function is used to calculate the remainder
      rem(code, 2) == 0
    end)

    %Identicon.Image{image | grid: grid}
  end

  def build_grid(image) do
    %Identicon.Image{hex: hex} = image
    grid = 
      hex
      |> Enum.chunk(3)
      # `&` character means that I'm about to pass a reference to a function
      # Then we write the name of our function
      # `/1` means that if for some reasons I have multiple functions called mirror_row
      # I specificly want the one that take one argument.
      |> Enum.map(&mirror_row/1)
      |> List.flatten
      |> Enum.with_index

    %Identicon.Image{image | grid: grid}
  end

  def mirror_row(row) do
    # start = [145, 46, 200]
    [first, second | _tail] = row

    # result = [145, 46, 200, 46, 145]
    # ++ is used in Elixir to manipulate lists
    row ++ [second, first]
  end

  def pick_color(image) do
    %Identicon.Image{hex: [red, green, blue | _tail]} = image
    %Identicon.Image{image | color: {red, green, blue}}
  end

  def hash_input(input) do
    # Without Pipe Operator
    # hash = :crypto.hash(:md5, input)
    # :binary.bin_to_list(hash)

    # With Pipe Operator
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Identicon.Image{hex: hex}
  end
end
