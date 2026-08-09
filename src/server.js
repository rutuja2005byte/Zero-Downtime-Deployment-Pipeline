const express = require("express");

const app = express();
const PORT = process.env.PORT || 3000;
const VERSION = process.env.APP_VERSION || "v1";

app.get("/", (req, res) => {
    res.json({
        message: "Zero-Downtime Deployment Pipeline",
        version: VERSION,
        status: "Application is running"
    });
});

app.get("/health", (req, res) => {
    res.status(200).json({
        status: "healthy",
        version: VERSION
    });
});

app.get("/version", (req, res) => {
    res.json({
        version: VERSION
    });
});

app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});