class ChatroomsController < ApplicationController
  def show
    @group = Group.find(params[:group_id])
    @event = @group.events.find(params[:event_id])
    @chatroom = @event.chatroom
    @message = Message.new
  end
end
