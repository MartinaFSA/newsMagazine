const express = require('express');
const cookieParser = require('cookie-parser');
const serverLog = require('easy-log');
const cors = require('cors');
const mysql = require('mysql2');

const app = express();

// Setup MySQL connection
const db = mysql.createConnection({
  host: '127.0.0.1',
  user: 'root',
  password: '546FED#fsdf',
  database: 'articles_active'
});

// Connect to MySQL
db.connect((err) => {
  if (err) {
    console.error('Error connecting to the database: ', err);
    process.exit(1);
  }
  console.log('Connected to MySQL database');
});

app.use((req, res, next) => {
  serverLog(`${req.method} - ${req.originalUrl}`)
  next()
})

app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(cors())

app.get('/', (req, res, next) => {
  res.send('Hello World')
})

// Route to fetch data from a table based on the table name
app.get('/data/:tableName', (req, res) => {
  const { tableName } = req.params;
  
  // Validate table name to avoid SQL injection
  const allowedTables = ['articles_active', 'outstanding_articles', 'drafts', 'articles_archive', 'userRoles', 'user', 'allCategories']; // Define the allowed tables for security
  if (!allowedTables.includes(tableName)) {
    return res.status(400).json({ error: 'Invalid table name' });
  }
  if(tableName === 'allCategories') {
    db.query(`SELECT category FROM articles_active GROUP BY category`, (err, results) => {
      if (err) {
        console.error('Error fetching data from table:', err);
        return res.status(500).json({ error: 'Database error' });
      }
      res.json(results);
    });
  } else if (tableName === 'getArticle-') {
    const id = tableName.split("-").pop();
    db.query(`SELECT * FROM articles_active WHERE id = ??`, [id], (err, results) => {
      if (err) {
        console.error('Error fetching data from table:', err);
        return res.status(500).json({ error: 'Database error' });
      }
      res.json(results);
    });
  }
  else {
    db.query(`SELECT * FROM ??`, [tableName], (err, results) => {
      if (err) {
        console.error('Error fetching data from table:', err);
        return res.status(500).json({ error: 'Database error' });
      }
      res.json(results);
    });
  }
});

// Route to fetch data from a table based on the table name
app.post('/data/:tableName', (req, res) => {
  const { tableName } = req.params;
  
  // Validate table name to avoid SQL injection
  const allowedTables = ['articles_active', 'outstanding_articles', 'drafts']; // 
  console.log(`Tried to post in ${tableName}.`);
  
  // $sql = "INSERT INTO articles_active ??`, [tableName], (title, type, tags, summary, body, authors, date, coverImg, artist, route, isOutstanding) VALUES ($title, $type, $tags, $summary, $body, $authors, $date, $coverImg, $artist, $route, $isOutstanding)"; 
});
// Start the server
const PORT = process.env.PORT || 8000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
module.exports = app;
