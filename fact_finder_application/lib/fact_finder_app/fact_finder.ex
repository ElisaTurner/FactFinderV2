defmodule FactFinder do
  @facts_file "facts.txt"

  # Function to input a new fact
  def input_fact(statement) do
    [fact_type | value_parts] = String.split(statement, " ")
    downcased_fact_type = String.downcase(fact_type)
    value = Enum.join(value_parts, ", ")
    updated_facts = read_facts() ++ [{String.to_atom(downcased_fact_type), value}]
    write_facts(updated_facts)
    IO.puts("Input Fact: #{downcased_fact_type} #{value}")
    updated_facts
  end

  # Query for a fact with placeholders
  def query_facts(query_fact) do
    [fact_type | placeholders] = String.split(query_fact, " ")
    downcased_fact_type = String.downcase(fact_type)
    stored_facts = read_facts()

    IO.puts("Query Fact (Input): #{downcased_fact_type} #{placeholders}")

    matching_facts =
      stored_facts
      |> Enum.filter(fn {key, _} -> key == String.to_atom(downcased_fact_type) end)

    value_placeholder = placeholders |> List.first()

    if Enum.empty?(matching_facts) do
      IO.puts("---")
      IO.puts(false)
    else
      IO.puts("---")

      Enum.each(matching_facts, fn {_key, value} ->
        value_parts = String.split(value, ", ")
        match = Enum.zip([value_placeholder], value_parts)

        formatted_match =
          Enum.map(match, fn {placeholder, binding} -> "#{placeholder}: #{binding}" end)

        formatted_match |> Enum.each(&IO.puts/1)
      end)
    end

    :ok
  end

  def match_fact(statement) do
    downcased_statement = String.downcase(String.trim(statement))
    stored_facts = read_facts()

    IO.puts("Query Fact (Input): #{downcased_statement}")

    case Enum.find(stored_facts, fn {fact_type, _} ->
           String.downcase(fact_type) == String.downcase(downcased_statement)
         end) do
      {:ok, _} ->
        IO.puts("---")
        IO.puts(true)

      :error ->
        IO.puts("---")
        IO.puts(false)
    end

    :ok
  end

  # Internal function to read facts from the file
  def read_facts() do
    case File.read(@facts_file) do
      {:ok, content} ->
        content
        |> String.split("\n")
        |> Enum.map(&parse_fact_line/1)

      _ ->
        []
    end
  end

  defp parse_fact_line(line) do
    [fact_type | value_parts] = String.split(line, " ")
    {String.to_atom(fact_type), Enum.join(value_parts, " ")}
  end

  # Internal function to write facts to the file
  def write_facts(facts) do
    facts_str = Enum.map(facts, fn {key, value} -> "#{Atom.to_string(key)} #{value}" end)
    File.write!(@facts_file, Enum.join(facts_str, "\n"))
  end

  def delete_fact(statement) do
    downcased_statement = String.downcase(String.trim(statement))
    stored_facts = read_facts()

    updated_facts =
      stored_facts
      # Reverse the list to iterate from most recent
      |> Enum.reverse()
      |> Enum.reject(fn {fact, _} -> fact == String.to_atom(downcased_statement) end)

    write_facts(updated_facts)
    IO.puts("Deleted Fact: #{downcased_statement}")
    {:ok, updated_facts}
  end
end
