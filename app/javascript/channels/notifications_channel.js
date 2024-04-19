import consumer from "channels/consumer"

const navbar_top_element = document.getElementById('navbar-top-id');
const navbar_top_id = navbar_top_element.getAttribute('data-navbar-top-id');



consumer.subscriptions.create( { channel: "NotificationsChannel", navbar_id: navbar_top_id } , {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("Connected to Notifications Channel " + navbar_top_id)

    
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
  
    const element = document.getElementById('user-id');
    const user_id = Number(element.getAttribute('data-user-id'));

    const notificationsContainer = document.getElementById('notifications-desktop');
    let html1 = data.request_html;
    

    const emptyStateMessage = document.getElementsByClassName('no_notification_message')[0];
 
    let unread = document.getElementById('visually-hidden');

    if (data.request.receiver_id === user_id) {
      let html = document.getElementById(`request-${data.request.id}-desktop`);

    
      if (data.action === 'delete') {
      
        html.remove();
        
        if (notificationsContainer.innerText === '' || notificationsContainer.textContent.trim() == 'No new notifications') {
         
          emptyStateMessage.style.display="block";
        }
      } else if (data.action === "send") {
          emptyStateMessage.style.display="none";
   
          notificationsContainer.innerHTML = notificationsContainer.innerHTML + html1;
      }

      let rendered_notis = document.getElementById('rendered_notis_desktop');
  
      rendered_notis.outerHTML = data.notification_count;

    }
  }
});

const navbar_bottom_element = document.getElementById('navbar-bottom-id');
const navbar_bottom_id = navbar_bottom_element.getAttribute('data-navbar-bottom-id');

consumer.subscriptions.create( { channel: "NotificationsChannel", navbar_id: navbar_bottom_id } , {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("Connected to Notifications Channel " + navbar_bottom_id)

    
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
  
    const element = document.getElementById('user-id');
    const user_id = Number(element.getAttribute('data-user-id'));

    const notificationsContainer = document.getElementById('notifications-mobile');
    let html1 = data.request_html_mobile;
    

    const emptyStateMessage = document.getElementsByClassName('no_notification_message')[1];

    let unread = document.getElementById('visually-hidden');

    if (data.request.receiver_id === user_id) {
      let html = document.getElementById(`request-${data.request.id}-mobile`);

    
      if (data.action === 'delete') {
      
        html.remove();
        
        if (notificationsContainer.innerText === '' || notificationsContainer.textContent.trim() == 'No new notifications') {
         
          emptyStateMessage.style.display="block";
        }
      } else if (data.action === "send") {
          emptyStateMessage.style.display="none";
   
          notificationsContainer.innerHTML = notificationsContainer.innerHTML + html1;
      }

      let rendered_notis = document.getElementById('rendered_notis_mobile');
      
      rendered_notis.outerHTML = data.notification_bottom_count;
      console.log(data.notification_bottom_count);
    }
  }
});