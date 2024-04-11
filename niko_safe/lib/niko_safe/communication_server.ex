defmodule NikoSafe.CommunicationServer do
  alias NikoSafe.Communication.Voice
  alias NikoSafe.Communication.Sms
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  # a sync process to check if an item is in the db
  def check_in_db(pid, unique_id) do
    GenServer.call(pid, {:check_in_db, unique_id}, 10000)
  end

  def send_confirm_message(pid, details) do
    GenServer.call(pid, {:send_confirm_message, details}, 20000)
  end

  # send to responders
  def to_responders(pid, details) do
    GenServer.call(pid, {:to_responders, details}, 10000)
  end

  # make call to ask for help
  def make_a_call(pid, phone_number) do
    GenServer.call(pid, {:make_a_call, phone_number}, 10000)
  end

  # this will send  a trigger message
  # the details
  # should be the 
  @spec trigger_for_help(pid(), map()) :: any()
  def trigger_for_help(pid, details) do
    GenServer.call(pid, {:trigger_for_help, details}, 20000)
  end

  # server

  def init(state) do
    {:ok, state}
  end

  def handle_call({:send_confirm_message, details}, _from, state) do
    response = Sms.send_confirmation_message(details.phone_number, details.data)
    {:reply, response, state}
  end

  def handle_call({:to_responders, details}, _from, state) do
    response = Sms.send_confirmation_message_to_responders(details.data)
    {:reply, response, state}
  end

  # this should handle call default 5mis
  def handle_call({:make_a_call, phone_number}, _from, state) do
    response = Voice.make_call(phone_number)
    {:reply, response, state}
  end

  def handle_call({:trigger_for_help, details}, _from, state) do
    IO.puts("this is working")
    IO.inspect(details)
    response = trigger(details)

    {:reply, response, state}
  end

  # this if the function containing the trigger 
  def trigger(details) do
   voice = Voice.make_call(details.emergency_responders)

    sms =
      Sms.send_message(details.emergency_responders, " #{details.name} has an emergency. PLEASE HELP!!")

    IO.inspect(voice.status)
    IO.inspect(sms)
    %{voice: voice.status, sms: sms}
  end
end
