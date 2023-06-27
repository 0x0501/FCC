import express from "express";
import "dotenv/config";
import mongoose from "mongoose";
import { fileURLToPath } from "url";
import { dirname, resolve } from "path";
import { lookup } from "dns";

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const app = express();

app.use(express.static(resolve(__dirname, "public")));
app.use(express.json()); // parsing application/json
app.use(express.urlencoded({ extended: true })); // parsing application/x-www-form-urlencoded

// generator short url
app.post("/api/shorturl/", (req, res) => {
	const receivedURL = req.body.url ?? "";

	try {
		const urlBuilder = new URL(receivedURL);

		lookup(urlBuilder.hostname, err => {
			if (err) {
				res.json({ error: "invalid url" });
			} else {
                // ...do sth
				res.json({ original_url: "[URL]", short_url: 1000 });
			}
		});
	} catch (err) {
		res.json({ error: "invalid url" });
	}
});

// intercept request
app.use(
	"/api/shorturl/:identity",
	(req, res, next) => {
		console.log(req.params.identity);
		next();
	},
	(req, res) => {
		res.json("ok");
	}
);

app.listen(process.env["EXPRESS_PORT"], () => {
	console.log(`Express is listening on ${process.env["EXPRESS_PORT"]}`);
});
