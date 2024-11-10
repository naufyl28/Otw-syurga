const functions = require("firebase-functions");
const axios = require("axios");

exports.getPrayerTimes = functions.https.onRequest(async (req, res) => {
  try {
    const response = await axios.get("https://muslimsalat.com/balikpapan.json");
    res.status(200).json(response.data);
  } catch (error) {
    res.status(500).send("Error fetching prayer times");
  }
});
