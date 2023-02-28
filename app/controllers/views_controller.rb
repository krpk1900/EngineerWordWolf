class ViewsController < ApplicationController
  before_action :set_uuid, except: :generate_uuid

  def generate_uuid
    @uuid = SecureRandom.alphanumeric(10)
    redirect_to("http://localhost:3000/top?uuid=#{@uuid}")
  end

  def top;end

  def share;end

  def waiting
    @connection_count = ActionCable
                      .server.open_connections_statistics
                      .map { |con| con[:subscriptions]
                      .map { |sub| JSON.parse(sub)["uuid"] } }
                      .flatten
                      .select { |uuid| uuid == @uuid }
                      .size

    ActionCable.server.broadcast('room_channel', {connection_count: @connection_count})
  end

  def play;end

  def vote;end

  def result;end

  private

  def set_uuid
    @uuid = params[:uuid]
  end
end
