import express from "express";
import "dotenv/config";
import { fileURLToPath } from "url";
import { dirname, resolve } from "path";
import { lookup } from "dns";
import DB from "./Database.js";
import { URLSchema, URLStruct } from "./schema/URLSchema.js";

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
				DB.then(async instance => {
					const URL = instance.model("URL", URLSchema);

					// if the url doesn't exist in database
					const isUrlExist = await URL.findOne({
						original_url: receivedURL,
					});

					/**@type {URLStruct} */
					let returnedData;

					if (isUrlExist === null) {
						console.log("Do not exist, creating one: " + receivedURL);

						const urlInstance = new URL({
							original_url: receivedURL,
							shorter_identity: 0x1,
						});

						returnedData = await urlInstance.save();
					} else {
						console.log("Already exist, return data");
						returnedData = isUrlExist;
					}
					res.json({
						original_url: receivedURL,
						short_url: returnedData.shorter_identity,
					});
				}).catch(err => {
					console.log(`DB Error: ${err}`);
					res.json({
						error: "internal Error 500",
					});
				});
			}
		});
	} catch (err) {
		res.json({ error: "invalid url" });
	}
});

// intercept request
app.get("/api/shorturl/:identity", async (req, res) => {
	const instance = await DB;
	const URL = instance.model("URL", URLSchema);

	/**@type {URLStruct} */
	const returnedData = await URL.findOne({
		shorter_identity: req.params.identity,
	});

	if (returnedData !== null) {
		res.redirect(returnedData.original_url);
	} else {
		res.json({ error: "No short URL found for the given input" });
	}
});

app.listen(process.env["EXPRESS_PORT"], () => {
	console.log(`Express is listening on ${process.env["EXPRESS_PORT"]}`);
});
