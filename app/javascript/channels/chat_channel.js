import consumer from "channels/consumer"

const chat_element = document.getElementById('chat-id');
<<<<<<< HEAD
const chat_id = Number(chat_element.getAttribute('data-chat-id'));
=======
const chat_id = chat_element.getAttribute('data-chat-id');
>>>>>>> testing

console.log(consumer.subscriptions)

consumer.subscriptions.subscriptions.forEach((subscription) => {
  consumer.subscriptions.remove(subscription)
});

<<<<<<< HEAD
consumer.subscriptions.create({ channel: "ChatChannel", chat_id: chat_id },  {
=======
consumer.subscriptions.create({channel: "ChatChannel", chat_id: chat_id },  {
>>>>>>> testing
  connected() {
    console.log("connected to " + chat_id)
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    console.log(data)

    const element = document.getElementById('user-id');
<<<<<<< HEAD
    const user_id = Number(element.getAttribute('data-user-id'));

=======
    console.log(element);
    const user_id = Number(element.getAttribute('data-user-id'));
    console.log(user_id);
>>>>>>> testing
    let html;

    if (user_id === data.message.user_id) {
      html = data.mine
    } else {
      html = data.theirs
    }

<<<<<<< HEAD
    const messageContainer = document.getElementById('messages')
    messageContainer.innerHTML = messageContainer.innerHTML + html
=======
    const messageContainer = document.getElementById('messages');
    messageContainer.innerHTML = messageContainer.innerHTML + html;
    console.log('hi');

    
>>>>>>> testing

    function scrollChatRoomToBottom() {
      var chatRoom = document.querySelector('.chat-room');
      chatRoom.scrollTop = chatRoom.scrollHeight;
    };
    
    
    scrollChatRoomToBottom();
  }
});
