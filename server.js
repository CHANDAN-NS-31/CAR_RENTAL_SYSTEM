const express = require('express');
const mysql = require('mysql');
const bodyParser = require('body-parser');
const cors = require('cors');
const path = require('path');

const app = express();
app.use(bodyParser.json());
app.use(cors());

const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'root123',
    database: 'rental'
});

connection.connect(err => {
    if (err) {
        console.error('Error connecting to MySQL:', err);
        return;
    }
    console.log('Connected to MySQL database.');
});

// Serve static files (like images and CSS)
app.use(express.static(path.join(__dirname)));

// Fetch cars
app.get('/cars', (req, res) => {
    connection.query('SELECT * FROM cars', (err, results) => {
        if (err) {
            console.error('Error fetching cars:', err);
            res.status(500).send('Error fetching cars');
        } else {
            res.json(results);
        }
    });
});

// Fetch locations
app.get('/locations', (req, res) => {
    connection.query('SELECT * FROM locations', (err, results) => {
        if (err) {
            console.error('Error fetching locations:', err);
            res.status(500).send('Error fetching locations');
        } else {
            res.json(results);
        }
    });
});

// Handle car rentals
app.post('/rentals', (req, res) => {
    const { username, car, location, rental_date, return_date } = req.body;

    if (!username || !car || !location || !rental_date || !return_date) {
        res.status(400).send('Missing required fields');
        return;
    }

    const rentalDays = Math.ceil((new Date(return_date) - new Date(rental_date)) / (1000 * 60 * 60 * 24));

    connection.query('SELECT daily_rate FROM cars WHERE car_id = ?', [car], (err, results) => {
        if (err) {
            console.error('Error fetching daily rate:', err);
            res.status(500).send('Error fetching daily rate');
            return;
        }

        if (results.length === 0) {
            res.status(404).send('Car not found');
            return;
        }

        const dailyRate = results[0].daily_rate;
        const totalAmount = rentalDays * dailyRate;

        connection.query('SELECT user_id FROM users WHERE username = ?', [username], (err, userResults) => {
            if (err) {
                console.error('Error fetching user ID:', err);
                res.status(500).send('Error fetching user ID');
                return;
            }

            if (userResults.length === 0) {
                res.status(404).send('User not found');
                return;
            }

            const user_id = userResults[0].user_id;
            const query = 'INSERT INTO rentals (user_id, car_id, location_id, rental_date, return_date, total_amount) VALUES (?, ?, ?, ?, ?, ?)';

            connection.query(query, [user_id, car, location, rental_date, return_date, totalAmount], (err, result) => {
                if (err) {
                    console.error('Error creating rental:', err);
                    res.status(500).send('Error creating rental');
                    return;
                }

                res.json({ rental_id: result.insertId });
            });
        });
    });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});
