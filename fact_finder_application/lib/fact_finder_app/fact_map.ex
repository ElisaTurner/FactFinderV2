defmodule FactMap do
  # Update a map with a given key using a custom update function
  def update!(map, key, default_value, update_func) do
    # Create an updated function that appends the result of update_func to the existing value
    updated_func = fn existing_value ->
      existing_value ++ update_func.()
    end

    case Map.get(map, key) do
      nil ->
        # If the key doesn't exist in the map, update it with default_value
        case Map.update(map, key, default_value, updated_func) do
          {:ok, updated_map} -> updated_map
          :error -> Map.put(map, key, default_value)
        end

      existing_value when is_list(existing_value) ->
        # If the existing value is a list, update it with the result of update_func
        updated_value = updated_func.(existing_value)

        case Map.update(map, key, updated_value, fn _ -> updated_value end) do
          {:ok, updated_map} -> updated_map
          :error -> Map.put(map, key, updated_value)
        end

      # If the value associated with the key is not a list, raise an error
      _ ->
        raise ArgumentError, "The value associated with the key must be a list."
    end
  end
end
