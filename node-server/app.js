const express = require('express');
const cookieParser = require('cookie-parser');
const serverLog = require('easy-log');
const cors = require('cors');
const mysql = require('mysql2');
const dotenv = require('dotenv');

// Load environment variables from .env file
dotenv.config();

const app = express();

// Setup MySQL connection
const db = mysql.createConnection({
  host: process.env.DB_HOST || '127.0.0.1',
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASSWORD || '',
  database: process.env.DB_NAME || 'articles_active'
});

// Connect to MySQL
db.connect((err) => {
  if (err) {
    console.error('Error connecting to the database: ', err);
    process.exit(1);
  }
  console.log('Connected to MySQL database');
});

// Middleware for logging
app.use((req, res, next) => {
  serverLog(`${req.method} - ${req.originalUrl}`);
  next();
});

app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(cors());

// Helper function to handle DB queries
const queryDatabase = (query, params = []) => {
  return new Promise((resolve, reject) => {
    db.query(query, params, (err, results) => {
      if (err) {
        reject(err);
      } else {
        resolve(results);
      }
    });
  });
};

// Route to test server
app.get('/', (req, res) => {
  res.send('Hello World');
});

// Route to fetch data from a table based on the table name
app.get('/data/:tableName', async (req, res) => {
  const { tableName } = req.params;
  console.log(`Called for table: ${tableName}`);

  // Validate table name to avoid SQL injection
  const allowedTables = ['articles_active', 'outstanding_articles', 'drafts', 'articles_archive', 'userRoles', 'user', 'allCategories', 'recentFiveCategorized'];
  if (!allowedTables.includes(tableName)) {
    return res.status(400).json({ error: 'Invalid table name' });
  }

  try {
    let results;
    if (tableName === 'allCategories') {
      results = await queryDatabase('SELECT category FROM articles_active GROUP BY category');
    } else if (tableName.startsWith('getArticle-')) {
      const id = tableName.split('-').pop();
      results = await queryDatabase('SELECT * FROM articles_active WHERE id = ?', [id]);
    } else if (tableName === 'recentFiveCategorized') {
      results = await queryDatabase('WITH ranked_articles AS ( SELECT *, ROW_NUMBER() OVER (PARTITION BY category ORDER BY date) AS row_num FROM articles_active ) SELECT ranked_articles.id, title, authors, artist, categories.name as category FROM ranked_articles LEFT JOIN categories ON ranked_articles.category = categories.id WHERE ranked_articles.row_num <= 5;');
    } else {
      results = await queryDatabase('SELECT * FROM ??', [tableName]);
    }

    return res.json(results); // Return query results

  } catch (err) {
    console.error('Error fetching data from table:', err);
    return res.status(500).json({ error: 'Database error' });
  }
});

// Route to handle POST requests for inserting data
app.post('/data/:tableName', async (req, res) => {
  const { tableName } = req.params;
  
  // Validate table name to avoid SQL injection
  const allowedTables = ['articles_active', 'outstanding_articles', 'drafts'];
  if (!allowedTables.includes(tableName)) {
    return res.status(400).json({ error: 'Invalid table name' });
  }

  console.log(`Tried to post in ${tableName}.`);

  // Example: Handle the insertion logic for `articles_active`
  if (tableName === 'articles_active') {
    const { title, type, tags, summary, body, authors, date, coverImg, artist, route, isOutstanding } = req.body;

    const insertQuery = `
      INSERT INTO articles_active (title, type, tags, summary, body, authors, date, coverImg, artist, route, isOutstanding)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`;

    try {
      await queryDatabase(insertQuery, [title, type, tags, summary, body, authors, date, coverImg, artist, route, isOutstanding]);
      return res.status(201).json({ success: true });
    } catch (err) {
      console.error('Error inserting data into table:', err);
      return res.status(500).json({ error: 'Database error' });
    }
  }

  res.status(400).json({ error: 'Unsupported table for POST' });
});

// Start the server
const PORT = process.env.PORT || 8000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});

module.exports = app;