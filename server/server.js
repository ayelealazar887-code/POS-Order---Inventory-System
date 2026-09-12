import express from "express"
import cors from "cors"
import dotenv from "dotenv"

dotenv.config()
const app = express()
app.use(express.json())
app.use(cors())

const port = process.env.PORT || 3000;

app.get("/api/health", (req, res) => {
    res.json({
        message: "POST API is running"
    })
})


app.listen(port, () => {
    console.log(`server running on port ${port}`)
})