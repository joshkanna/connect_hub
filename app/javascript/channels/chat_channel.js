import consumer from "channels/consumer"

if (document.getElementById('chat-id')) {
  const chat_element = document.getElementById('chat-id');
  const chat_id = chat_element.getAttribute('data-chat-id');


  console.log(consumer.subscriptions)

  consumer.subscriptions.subscriptions.forEach((subscription) => {
    consumer.subscriptions.remove(subscription)
  });

  consumer.subscriptions.create({channel: "ChatChannel", chat_id: chat_id },  {
    connected() {
      console.log("connected to " + chat_id)
      // Called when the subscription is ready for use on the server
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received(data) {


      const element = document.getElementById('user-id');
    
      const user_id = Number(element.getAttribute('data-user-id'));
  
      let html;

      if (user_id !== data.message.user_id) {
        html = data.theirs
        const messageContainer = document.getElementById('messages');
        messageContainer.innerHTML = messageContainer.innerHTML + html;
      }

  
      var chatBox = document.getElementById('message_content')
      chatBox.value = ''

      

      function scrollChatRoomToBottom() {
        var chatRoom = document.querySelector('.chat-room');
        chatRoom.scrollTop = chatRoom.scrollHeight;
      };
      
      
      scrollChatRoomToBottom();
    }
  });
}