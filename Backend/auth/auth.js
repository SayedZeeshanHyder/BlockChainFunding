// auth.js
const express = require("express");
const jwt = require("jsonwebtoken");
require("dotenv").config()
const router = express.Router();
const SECRET_KEY = `${process.env.SECRET_KEY}`; // Ensure this is set in your .env file

// Route for user login and token generation
router.post("/login", (req, res) => {
    const { account } = req.body;

    if (!account) {
        return res.status(400).json({ error: "Account is required" });
    }

    // Generate a JWT token
    if (!SECRET_KEY) {
        return res.status(500).json({ error: "SECRET_KEY is not defined" });
    }

    try {
        const token = jwt.sign({ account }, SECRET_KEY, { expiresIn: "1h" });
        res.json({ token });
    } catch (err) {
        res.status(500).json({ error: "Failed to generate token" });
        console.error("Token generation error:", err);
    }
});

// Route for verifying the JWT token
router.post("/verify", (req, res) => {
    const { token } = req.body;

    if (!token) {
        return res.status(400).json({ error: "Token is required" });
    }

    if (!SECRET_KEY) {
        return res.status(500).json({ error: "SECRET_KEY is not defined" });
    }

    try {
        const decoded = jwt.verify(token, SECRET_KEY);
        res.json({ valid: true, account: decoded.account });
    } catch (err) {
        res.status(401).json({ valid: false, error: "Invalid or expired token" });
        console.error("Token verification error:", err);
    }
});

module.exports = router;
