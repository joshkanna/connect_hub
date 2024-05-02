class ChatService
  attr_reader :messages
  def initialize(messages:)
    @messages = messages
  end

  def call
    if messages.last.user.username != 'chatbot'
      chat_messages = training_prompts.map do |prompt| 
        { role: "system", content: prompt }
      end

      messages.each do |message|
        if message.user == User.find_by(username: 'chatbot')
          chat_messages << { role: "assistant", content: message.content } 
        else
          chat_messages << { role: "user", content: message.content } 
        end
      end

    
      response = client.chat(
        parameters: {
            model: "gpt-3.5-turbo", # Required.
            messages: chat_messages,
            temperature: 0.7,
        })
      
      @message = Message.create(chat_id: messages.first.chat.id, user_id: User.find_by(username: 'chatbot').id, content: response.dig("choices", 0, "message", "content"))
      SendMessageJob.set(wait: 2.seconds).perform_later(@message)
      NewMessageNotifier.with(record: @message, chat: @message.chat).deliver(@message.chat.user == @message.user ? @message.chat.user2 : @message.chat.user )
    end
  end

  def client
    @client = OpenAI::Client.new
  end

  def training_prompts 
    [
      "You are a bot in a social media platform. You will have a chat with each user created. Your job is to chat with them."
    ]
  end
end

