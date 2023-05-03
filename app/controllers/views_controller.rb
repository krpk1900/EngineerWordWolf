class ViewsController < ApplicationController
  before_action :set_uuid, except: :generate_uuid

  # @route GET /generate_uuid (generate_uuid)
  def generate_uuid
    @uuid = SecureRandom.alphanumeric(10)
    redirect_to("http://localhost:3000/top?uuid=#{@uuid}")
  end

  # @route GET /top (top)
  def top;end

  # @route GET /share (share)
  def share;end

  # @route GET /waiting (waiting)
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

  # @route GET /play (play)
  def play;end

  # @route GET /vote (vote)
  def vote;end

  # @route GET /result (result)
  def result;end

  private

  def set_uuid
    @uuid = params[:uuid]
  end
end
