import consumer from "channels/consumer"

consumer.subscriptions.create("NotificationsChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("Connected to Notifications Channel.")
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel

    console.log(data.request.id);
    const element = document.getElementById('user-id');
    const user_id = Number(element.getAttribute('data-user-id'));

    const notificationsContainer = document.getElementById('notifications');
    let html1 = data.request_html;
    

    const emptyStateMessage = document.getElementById('no_notification_message');


    if (data.request.receiver_id === user_id) {
      let html = document.getElementById(`request-${data.request.id}`);

      console.log("hi");
      if (data.action === 'delete') {
        html.remove();
        console.log(notificationsContainer.innerHTML);
        console.log(emptyStateMessage);
        if (notificationsContainer.innerText === '') {
          console.log("Got you!");
          emptyStateMessage.style.display="block";
        }
      } else {
          emptyStateMessage.style.display="none";
          console.log('reached');
          notificationsContainer.innerHTML = notificationsContainer.innerHTML + html1;
      }
    }
  }
});



