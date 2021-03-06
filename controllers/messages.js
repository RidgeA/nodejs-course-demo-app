const Message = require('../models/Message');

module.exports = async function messages(ctx, next) {
  const messages = await Message.find().sort({ date: 1 }).limit(20).populate('user');
  
  ctx.body = {
    messages: messages.map(message => ({
      time: `${message.date.getHours()}:${message.date.getMinutes()}`,
      text: message.text,
      id: message.id,
      author: message.user.displayName,
    }))
  };
};
