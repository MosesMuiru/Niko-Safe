defmodule Nikosafe.Gateway do

  use Tesla




  plug Tesla.Middleware.Headers, [
    {"accept", "application/json"},
    {"Content-Type", "application/x-www-form-urlencoded"}
  ]
  plug Tesla.Middleware.FormUrlencoded
  

  @spec post_to_at(%{}) :: any()
  def post_to_at(attr, type) do
    
    case attr.username do
    
      "nikosafe" -> post_live(attr)
      "sandbox" -> post_sandbox(attr)

    end

  end

  defp post_live(attr) do
    


  end


  
end
