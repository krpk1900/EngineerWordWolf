import consumer from "channels/consumer"

const appRoom = consumer.subscriptions.create(
  {
    channel: "RoomChannel",
    // ここを変えることでURLごとの接続数にする
    // url: location.href
    url: 'http://localhost:3000/waiting'
  },
  {
    connected() {
    },

    disconnected() {
    },

    received(data) {
      console.log(data['connection_count']);
      const connectionCount = document.getElementById('connection_count')
      if (connectionCount) {
        connectionCount.textContent = `現在${data['connection_count']}人が接続中`
      }
    }
  }
);
