import consumer from "channels/consumer";

consumer.subscriptions.create("Noticed::NotificationChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("Connected to noticed");
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel

    if (data.count) {
      const bell_badge = document.getElementsByClassName("bell");
      for (let i = 0; i < bell_badge.length; i++) {
        bell_badge[i].classList.remove("invisible");
      }
      const notificationCount = document.getElementsByClassName("notis_count");
      for (let i = 0; i < notificationCount.length; i++) {
        notificationCount[i].innerHTML = data.count;
      }
    } else if (data.messageCount) {
      if (document.getElementById("chat_users")) {
        const chatUsers = document.getElementById("chat_users");
        chatUsers.innerHTML = data.chatUsers;
      } else {
        const email_badge = document.getElementsByClassName("email");
        for (let i = 0; i < email_badge.length; i++) {
          email_badge[i].classList.remove("invisible");
        }
        const notificationCount = document.getElementsByClassName(
          "message_notis_count"
        );
        for (let i = 0; i < notificationCount.length; i++) {
          notificationCount[i].innerHTML = data.messageCount;
        }
      }
    }
  },
});
