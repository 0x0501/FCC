import express from "express";
import { dirname, resolve } from "path";
import { fileURLToPath } from "url";
/**
 * Express js doesn't import .env automatically, so we use `dotenv` lib
 */
import "dotenv/config";

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const app = express();

app.use(express.static(resolve(__dirname, "public")));

app.get('/api/whoami', (req, res) => {
    // set CORS header
    res.setHeader("Access-Control-Allow-Origin", "*");

    res.json({
        // get client address via net.socket
        ipaddress : req.socket.remoteAddress,
        language : req.headers["accept-language"],
        software : req.headers["user-agent"]
    });
})

console.log(process.env["EXPRESS_PORT"]);
app.listen(process.env.EXPRESS_PORT, () => {
	console.log(`Express is listening on ${process.env.EXPRESS_PORT}`);
});
