import pool from "../config/database.js"

try {
    const [rows] = await pool.query("SELECT 1 AS result");
    console.log("database connected:", rows)

    await pool.end();
} catch (error) {
    console.error("Database connection failed:", error);
}