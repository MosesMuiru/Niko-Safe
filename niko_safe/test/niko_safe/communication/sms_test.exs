defmodule NikoSafe.Communication.SmsTest do
  use ExUnit.Case

  describe "testing the sending of sms" do
    test "tesing single sms" do
      params = %{
        "sessionId" => 1,
        "serviceCode" => "*384*64244#",
        "phonenumber" => "0794741095l",
        "text" => "1"
      }

      response = simulate_http_call("POST", "api/ussd", params)
      assert response.status == 200
      assert response.text == "1"
    end
  end
end
