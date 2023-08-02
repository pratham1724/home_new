class ChatsController < ApplicationController
  def private_chat
    
    if current_user.client?
      @user2 = current_user.client
    else
      @user2 = current_user.trainer
    end

    if current_user.client?
       @user1 = Trainer.find(params[:trainer_id])
    else
      @user1 = Client.find(params[:client_id])
    end
    @room = Room.where("rooms.name LIKE ?", "%" + @user1.name + "%").where("rooms.name LIKE ?", "%" + @user2.name + "%").take(1)
    

    if @room.size > 0
      redirect_to room_path(@room)
    else
      @room = Room.create( name: @user1.name + "_" + @user2.name )
      redirect_to room_path(@room.id)
    end
  end
end
