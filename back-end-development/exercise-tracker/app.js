import { dirname, resolve } from "path";
import { fileURLToPath } from "url";
import express from "express";
import "dotenv/config";
import DB from "./Database.js";
import { UserSchema, UserStruct } from "./schema/UserSchema.js";
import { ExerciseStruct } from "./schema/ExerciseSchema.js";
import { LogSchema, LogStruct } from "./schema/LogSchema.js";

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const app = express();

// middleware for CORS request
app.use((_req, res, next) => {
	res.setHeader("Access-Control-Allow-Origin", "*");
	res.setHeader("Access-Control-Allow-Headers", "content-type");
	res.setHeader("Access-Control-Allow-Methods", "POST, GET");
	next();
});

// mount static file, because of our having a single page
// so we don't need to specify the route.
app.use(express.static(resolve(__dirname, "public")));

// middleware for accessing post data and urlencoded data
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// middleware for validating user id (Both post and GET request)
app.use("/api/users/:id/((logs|exercises))", (req, res, next) => {
	// if the incoming user id is NOT alphanumeric, terminate request
	if (new RegExp(/\w+/i).test(req.params.id)) {
		next();
	} else {
		res.json({
			error: "invalid user id",
		});
	}
});

/**
 * @description add user into database
 */
app.post("/api/users", async (req, res) => {
	const User = DB.model("user", UserSchema);

	const isExist = await User.findOne({
		username: req.body.username,
	});

	/**@type {UserStruct} */
	let queryResult = {};

	// if the user doesn't exist, add a new one
	if (isExist === null) {
		const userInstance = new User({
			username: req.body.username,
		});
		const saveResult = await userInstance.save();
		queryResult.username = saveResult.username;
		queryResult._id = saveResult._id.toString();
	} else {
		queryResult.username = isExist.username;
		queryResult._id = isExist._id.toString();
	}
	res.json(queryResult);
});

/**
 * @description add exercise of id indicated user into database
 */
app.post("/api/users/:id/exercises", (req, res) => {
	const User = DB.model("user", UserSchema);

	User.findById(req.params.id)
		.then(async data => {
			if (data === null) throw new Error(`No such user: ${req.params.id}`);

			const Log = DB.model("logs", LogSchema);

			/**@type {ExerciseStruct} */
			const exerciseMsg = {
				description: req.body.description,
				duration: req.body.duration,
				date:
					req.body.date === undefined || req.body.date == ""
						? new Date().toDateString()
						: new Date(req.body.date).toDateString(),
			};

			let isExistInLog = await Log.findOne({ username: data.username });

			/**@type {ExerciseStruct}*/
			let result = {
				username: data.username,
				_id: data._id.toString(),
			};

			if (isExistInLog === null) {
				const LogInstance = new Log({
					username: data.username,
					log: [exerciseMsg],
				});
				isExistInLog = await LogInstance.save();
			} else {
				// add this exercise to the array
				isExistInLog.log.push(exerciseMsg);
			}
			const actionResult = await isExistInLog.save();

			result.duration = actionResult.log[actionResult.log.length - 1].duration;
			result.description =
				actionResult.log[actionResult.log.length - 1].description;
			result.date = actionResult.log[actionResult.log.length - 1].date;

			res.json(result);
		})
		.catch(err => {
			res.json({
				error: `No user for such id: ${req.params.id}`,
			});
			console.log(err);
		});
});

/**
 * @description retrieve exercises from database, the query strings (optional) may be `from?`, `to?` or `limit?`
 */
app.get("/api/users/:id/logs", (req, res) => {
	const User = DB.model("user", UserSchema);

	User.findById(req.params.id)
		.then(async data => {
			const Log = DB.model("logs", LogSchema);

			const logs = await Log.findOne({
				username: data.username,
			});

			const validator = property => {
				if (Reflect.get(req.query, property) !== undefined) {
					const dateTest = new Date(Reflect.get(req.query, property));
					return !Number.isNaN(dateTest.getTime());
				} else {
					return false;
				}
			};

			const filterLog = (data_arr, from, to, limit) => {
				const arr = data_arr.filter(record => {
					const createdDate = new Date(record.date);

					if (from !== undefined) {
						const fromDateThen = new Date(from);
						const toDateThen = new Date(to ?? Date.now());
						return createdDate >= fromDateThen && createdDate <= toDateThen;
					} else if (result.to !== undefined) {
						const toDateThen = new Date();
						return createdDate <= toDateThen;
					} else {
						return true;
					}
				});
				// if the second param is undefined, it'll work as `slice(0)`
				return arr.slice(0, limit);
			};

			/**@type {LogStruct} */
			const result = {};

			result._id = req.params.id;
			result.username = data.username;

			if (validator("from")) {
				result.from = new Date(req.query.from).toDateString();
			}

			if (validator("to")) {
				result.to = new Date(req.query.to).toDateString();
			}

			result.log = filterLog(
				logs.log,
				result.from,
				result.to,
				req.query.limit ?? undefined
			);

			// count records
			result.count = result.log.length;

			res.json(result);
		})
		.catch(err => {
			res.json({
				error: `No user for such id: ${req.params.id}`,
			});
			console.log(err);
		});
});

app.listen(process.env["EXPRESS_PORT"], () => {
	console.log(`Express JS is listening on ${process.env["EXPRESS_PORT"]}`);
});
