import express from "express";
import { dirname, resolve } from "path";
import { fileURLToPath } from "url";

const app = express();
const port = 3000;

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

app.use(express.static(resolve(__dirname, "public")));

app.get("/api/:date?", (req, res) => {
	const RESULT = {
		unix: 1, // unix milliseconds
		utc: "", // utc string
	};

	// set CORS header
	res.setHeader("Access-Control-Allow-Origin", "*");

	// if the `date` param is empty, return current date
	if (req.params.date === undefined) {
		RESULT.unix = Date.now();
		RESULT.utc = new Date().toUTCString();
		res.json(RESULT);
	} else {
		const incoming_date = /^[0-9]+$/.test(req.params.date)
			? Number(req.params.date)
			: req.params.date;
		const ms = new Date(incoming_date);
		if (Number.isNaN(ms.getTime())) {
			res.json({
				error: "Invalid Date",
			});
		} else {
			RESULT.unix = ms.valueOf();
			RESULT.utc = ms.toUTCString();
			res.json(RESULT);
		}
	}
});

app.get("/", express.static(resolve(__dirname, "public")));

app.listen(port, () => {
	console.log(`Express is listening on ${port}`);
});
