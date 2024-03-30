defmodule NikoSafe.Communication.Ussd do
  alias NikoSafe.Communication.Sms

  @moduledoc """

    this contains the extaction of data from the ussd

    

  """
  @type return_data :: %{
          name: String.t(),
          garget_id: String.t(),
          phone_number: list(integer | String.t())
        }

  @spec extract_data_from_ussd(String.t()) :: return_data
  def extract_data_from_ussd(ussd_data) do
    data =
      String.split(ussd_data, "*")
      |> List.to_tuple()

    %{
      name: elem(data, 1),
      garget_id: elem(data, 2),
      phone_number: elem(data, 3)
    }
  end

  @doc """

  input validatoin
  this is to validate that the data  is valid
  that is the phone number is 10 digits
  then the name has no digits


  """
end
