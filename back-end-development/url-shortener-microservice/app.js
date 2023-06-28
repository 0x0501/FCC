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

// global middleware for CORS, this must be the first middleware
app.use((req, res, next) => {
	res.setHeader("Access-Control-Allow-Origin", "*");
	next();
})

app.use(express.static(resolve(__dirname, "public")));
app.use(express.json()); // parsing application/json
app.use(express.urlencoded({ extended: true })); // parsing application/x-www-form-urlencoded

// POST middleware
app.post("/api/shorturl/", (req, res, next) => {
	const receivedURL = req.body.url ?? "";

	new Promise((resolve, reject) => {
		try {
			/**
			 * try-catch block is for URL constructors.
			 * If we pass invalid url to URL constructor, we will get an error.
			 */
			const urlBuilder = new URL(receivedURL);
			// lookup uses callback rather than Promise, so we simply wrap it.
			lookup(urlBuilder.hostname, err => {
				if (err) {
					reject(err);
				}else {
					resolve();
				}
			});
		} catch (e) {
			reject(e);
		}
	}).then(() => {
		//if no error occurs, pass by
		next();
	}).catch(_err => {
		console.log("Middleware intercepted...");
		res.json({ error: "invalid url" });
	})

	
});

// generator short url
app.post("/api/shorturl/", (req, res) => {
	const receivedURL = req.body.url ?? "";

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

			const createIdentity = async () => {
				const identities = await URL.find().sort('shorter_identity');
				const identities_num_only = identities.map(record => record.shorter_identity);

				// no records found, create the first one from 1
				if (identities_num_only.length === 0) {
					return 1;
				}else {
					// find the largest number and then add 1 into it.
					return identities_num_only[identities_num_only.length - 1] + 1;
				}
			}
			const urlInstance = new URL({
				original_url: receivedURL,
				shorter_identity: await createIdentity(),
			});

			returnedData = await urlInstance.save();

			console.log(returnedData)
		} else {
			console.log(`${receivedURL} Already exist, return data`);
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
