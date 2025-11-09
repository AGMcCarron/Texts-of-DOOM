const express = require("express");
const path = require("path");
const fetch = require("node-fetch"); // ✅ this import
const cors = require("cors");

const app = express();
const port = 8080;

app.use(cors());
app.use(express.static(__dirname));

app.get("/", (req, res) => {
  res.sendFile(path.join(__dirname, "webPage.html"));
});

app.get("/send", async (req, res) => {
  const { username, message } = req.query;
  console.log(`📩 Incoming message: ${username}: ${message}`);

  try {
    const response = await fetch.default(
      "https://api-durhack.talkjs.com/v1/tJU4ulfD/conversations/globalConv/messages",
      {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer sk_test_NFYeWRuqB7dgHwEv382IbOJMdQUjj1RE`,
        },
        body: JSON.stringify([
          {
            text: `${username}: ${message}`,
            sender: "Server",
            type: "UserMessage",
          },
        ]),
      }
    );

    const text = await response.text();
    console.log("🔍 TalkJS response:", response.status, text);

    if (!response.ok) {
      res.status(response.status).send(text || "TalkJS API error");
      return;
    }

    res.status(200).send("✅ Message sent successfully!");
  } catch (err) {
    console.error("💥 Node server error:", err);
    res.status(500).send(err.message || "Internal Server Error");
  }
});

app.listen(port, "0.0.0.0", () => {
  console.log(`✅ Chat server running at http://localhost:${port}`);
});
