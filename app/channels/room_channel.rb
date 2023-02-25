class RoomChannel < ApplicationCable::Channel
  def subscribed
    p '========================='
    p 'subscribedされた'
    p '========================='
    stream_from "room_channel"
    send_connection_count
  end

  def unsubscribed
    send_connection_count
  end

  private

  def send_connection_count
    connection_count = ActionCable
                    .server.open_connections_statistics
                    .map { |con| con[:subscriptions]
                    .map { |sub| JSON.parse(sub)["url"] } }
                    .flatten
                    .select { |url| url == 'http://localhost:3000/waiting' } # todo: uuidを含めたURLにする
                    .size

    ActionCable.server.broadcast('room_channel', {connection_count: connection_count})

    p "-----------------send_connection_count-----------------"
    p ActionCable.server.open_connections_statistics.map { |con| con[:subscriptions].map { |sub| JSON.parse(sub)["url"] } }.flatten
    p "@connection_count = #{connection_count}"
    p "----------------------------------"
  end
end
