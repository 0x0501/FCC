import express from 'express'
import 'dotenv/config';
import mongoose from 'mongoose';
import {fileURLToPath} from 'url';
import { dirname, resolve } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const app = express();

app.use(express.static(resolve(__dirname, 'public')));

// intercept request
app.use('/api/shorturl/:identity', (req, res, next) => {
    console.log(req.params.identity);
    next();
}, (req, res) => {
    res.json('ok')
})

// generator short url
app.post('/api/shorturl/:identity?', (req, res) => {
    
})



app.listen(process.env['EXPRESS_PORT'], () => {
    console.log(`Express is listening on ${process.env['EXPRESS_PORT']}`);
})