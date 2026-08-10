const request = require("supertest");

const express = require("express");

const app = express();

const VERSION = process.env.APP_VERSION || "v1";

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

describe("Application Health", () => {

    test("Health endpoint should return 200", async () => {
        const response = await request(app).get("/health");

        expect(response.statusCode).toBe(200);
        expect(response.body.status).toBe("healthy");
    });

    test("Version endpoint should return version", async () => {
        const response = await request(app).get("/version");

        expect(response.statusCode).toBe(200);
        expect(response.body.version).toBeDefined();
    });

});