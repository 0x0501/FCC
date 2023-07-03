import express from "express";
import multer from "multer";
import "dotenv/config";
import { fileURLToPath } from "url";
import { dirname, resolve } from "path";
import { readdirSync, unlinkSync } from "fs";

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);
const __catch = resolve(__dirname, "cache");

const app = express();

const uploadConfig = multer({ dest: __catch });

app.use((req, res, next) => {
	res.setHeader("Access-Control-Allow-Origin", "*");
	res.setHeader("Access-Control-Allow-Headers", "content-type");
	res.setHeader("Access-Control-Allow-Methods", "POST");
	next();
});

app.use(express.static(resolve(__dirname, "public")));


app.post("/api/fileanalyse", uploadConfig.single("upfile"), (req, res) => {
	res.json({
		name: req.file.originalname,
		type: req.file.mimetype,
		size: req.file.size,
	});

	const cacheFiles = readdirSync(__catch);
	cacheFiles.forEach(filename => {
		unlinkSync(resolve(__catch, filename));
	});
});

app.listen(process.env["EXPRESS_PORT"], () => {
	console.log(`Express is listening on ${process.env["EXPRESS_PORT"]}`);
});
