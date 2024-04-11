import consumer from "channels/consumer"

consumer.subscriptions.create("MessageChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("Connected to Message Channel")
    
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    const messageContainer = document.getElementById('messages');
    const element = document.getElementById('user-id');
    console.log(element);
    const user_id = Number(element.getAttribute('data-user-id'));
    console.log(user_id);
    console.log(data.message.user_id);
    if (data.action === 'delete') {  
      let html;
      
      if (user_id === data.message.user_id) {
        html = document.getElementById(`message-${data.message.id}-me`)
      } else {
        html = document.getElementById(`message-${data.message.id}`)
      }
      
      
      console.log(html);
      html.remove()
    }
  }
})