import { dirname, resolve } from "path";
import { fileURLToPath } from "url";
import express from "express";
import "dotenv/config";

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const app = express();

// mount static file, because of our having a single page
// so we don't need to specify the route.
app.use(express.static(resolve(__dirname, 'public')));

// middleware for CORS request
app.use((req, res, next) => {
    res.setHeader('Access-Control-Allow-Origin', '*');
    next();
})

app.listen(process.env["EXPRESS_PORT"], () => {
	console.log(`Express JS is listening on ${process.env["EXPRESS_PORT"]}`);
});
