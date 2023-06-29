import { dirname, resolve } from "path";
import { fileURLToPath } from "url";
import express from "express";
import "dotenv/config";

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const app = express();

// middleware for CORS request
app.use((req, res, next) => {
	res.setHeader("Access-Control-Allow-Origin", "*");
	next();
});

// mount static file, because of our having a single page
// so we don't need to specify the route.
app.use(express.static(resolve(__dirname, "public")));

// middleware for accessing post data and urlencoded data
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// middleware for validating user id (Both post and GET request)
app.use('/api/users/:id/((logs|exercises))', (req, res, next) => {
    // if the incoming user id is NOT alphanumeric, terminate request
    if (new RegExp(/\w+/i).test(req.params.id)) {
        next();
    }else {
        res.json({
            error : 'invalid user id'
        })
    }
})

/**
 * @description add user into database
 */
app.post('/api/users', (req, res) => {
    res.json({
        msg : 'add user success: ' + req.body.username
    })
});

/**
 * @description add exercise of id indicated user into database
 */
app.post('/api/users/:id/exercises', (req, res) => {
    res.json({
        msg : 'add exercise success'
    })
});

/**
 * @description retrieve exercises from database, the query strings (optional) may be `from?`, `to?` or `limit?`
 */
app.get('/api/users/:id/logs', (req, res) => {
    res.json({
        msg : 'query logs success'
    })
});

app.listen(process.env["EXPRESS_PORT"], () => {
	console.log(`Express JS is listening on ${process.env["EXPRESS_PORT"]}`);
});
