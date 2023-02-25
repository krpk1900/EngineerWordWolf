class ViewsController < ApplicationController
  def top; end

  def share; end

  def waiting
    @connection_count = ActionCable
                      .server.open_connections_statistics
                      .map { |con| con[:subscriptions]
                      .map { |sub| JSON.parse(sub)["url"] } }
                      .flatten
                      .select { |url| url == 'http://localhost:3000/waiting' } # todo: uuidを含めたURLにする
                      .size

    p "----------------ViewsController------------------"
    p ActionCable.server.open_connections_statistics.map { |con| con[:subscriptions].map { |sub| JSON.parse(sub)["url"] } }.flatten
    p "@connection_count = #{@connection_count}"
    p "----------------------------------"

    ActionCable.server.broadcast('room_channel', {connection_count: @connection_count})
  end

  def play; end

  def vote; end

  def result; end
end

# ActionCable.server.open_connections_statistics
# ActionCable.server.open_connections_statistics.map { |con| con[:subscriptions].map { |sub| JSON.parse(sub)["url"] } }.flatten.select { |url| url == 'http://localhost:3000/waiting' }.size
