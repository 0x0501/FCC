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

console.log(process.env["EXPRESS_PORT"]);
app.listen(process.env.EXPRESS_PORT, () => {
	console.log(`Express is listening on ${process.env.EXPRESS_PORT}`);
});
