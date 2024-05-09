function scrollChatRoomToBottom() {
  var chatRoom = document.querySelector(".chat-room");
  chatRoom.scrollTop = chatRoom.scrollHeight;
}

scrollChatRoomToBottom();
