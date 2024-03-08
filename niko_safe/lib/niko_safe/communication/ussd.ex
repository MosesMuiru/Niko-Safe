defmodule NikoSafe.Communication.Ussd do


    @moduledoc """

    this contains the extaction of data from the ussd

    

  """
@type return_data :: %{
  name: String.t(),
  garget_id: String.t(),
  phone_number: list(integer | String.t())
}

  @spec extract_data_from_ussd(String.t()) :: return_data
  def extract_data_from_ussd(_ussd_data) do
    


  end 
end
