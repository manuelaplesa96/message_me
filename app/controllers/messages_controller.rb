class MessagesController < ApplicationController
    before_action :require_user
    
    def create 
        message = current_user.messages.build(message_params)
        if message.save
            ## sto se ovdje posalje prima se u recieved u chatroom.coffee
            ActionCable.server.broadcast "chatroom_channel", mod_message: message_render(message)
        end
    end

    private 

    def message_params
        params.require(:message).permit(:body)
    end

    def message_render(message)
        # koji partial pozivamo -> partial, koje podatke saljemo u taj partial jer ih mora primiti -> local
        render(partial: 'message', locals: {message: message})
      end
end