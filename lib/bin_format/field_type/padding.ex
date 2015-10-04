defmodule BinFormat.FieldType.Padding do
  defstruct value: nil

  defmacro padding(value) do
    field = quote do
      %BinFormat.FieldType.Padding{value: unquote(value)}
    end
    BinFormat.FieldType.Util.add_field(field)
  end

end

defimpl BinFormat.Field, for: BinFormat.FieldType.Padding do
  alias BinFormat.FieldType.Padding, as: Padding

  defp binary_match(%Padding{value: val}) when is_binary(val) do
    quote do
      _ :: binary-size(unquote(byte_size(val)))
    end
  end

  defp binary_match(%Padding{value: val}) when is_bitstring(val) do
    quote do
      _ :: bitstring-size(unquote(bit_size(val)))
    end
  end

  def struct_definition(_field, _module) do
    :undefined
  end

  def struct_build_pattern(_field, _module, _prefix) do
    :undefined
  end

  def struct_match_pattern(_field, _module, _prefix) do
    :undefined
  end

  def bin_build_pattern(%BinFormat.FieldType.Padding{value: value}, _module, _prefix) do
    {:ok, Macro.escape(value)}
  end

  def bin_match_pattern(field, _module, _prefix) do
    {:ok, binary_match(field)}
  end
end