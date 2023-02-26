class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel"
    send_connection_count
  end

  def unsubscribed
    send_connection_count
  end

  private

  def send_connection_count
    params_uuid = params[:uuid]

    connection_count = ActionCable
                    .server.open_connections_statistics
                    .map { |con| con[:subscriptions]
                    .map { |sub| JSON.parse(sub)["uuid"] } }
                    .flatten
                    .select { |uuid| uuid == params_uuid }
                    .size

    ActionCable.server.broadcast('room_channel', {connection_count: connection_count})
  end
end
