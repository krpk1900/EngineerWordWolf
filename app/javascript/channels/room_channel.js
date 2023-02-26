import consumer from "channels/consumer"

// uuidを取得
const url = new URL(window.location.href);
const params = new URLSearchParams(url.search);
const uuid = params.get('uuid')

const appRoom = consumer.subscriptions.create(
  {
    channel: "RoomChannel",
    uuid: uuid
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
