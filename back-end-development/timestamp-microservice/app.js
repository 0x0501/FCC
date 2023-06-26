import express from 'express';
import { dirname, resolve } from 'path';
import { fileURLToPath } from 'url';

const app = express();
const port = 3000;

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

app.use(express.static(resolve(__dirname, 'public')));

app.get('/api/:date', (req, res) => {
    const RESULT = {
        unix : 1, // unix milliseconds
        utc : "" // utc string
    };
    const incoming_date = /^[0-9]+$/.test(req.params.date) ? Number(req.params.date) : req.params.date;
    const ms = new Date(incoming_date);
    if (Number.isNaN(ms)) {
        res.json({
            error : "Invalid Date"
        })
    }else {
        RESULT.unix = ms.valueOf();
        RESULT.utc = ms.toUTCString();
        res.json(RESULT);
    }
});

app.listen(port, () => {
    console.log(`Express is listening on ${port}`);
});