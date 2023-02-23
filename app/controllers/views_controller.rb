class ViewsController < ApplicationController
  def top; end

  def share; end

  def waiting
    @connection_count = 1
  end

  def play; end

  def vote; end

  def result; end
end
