const express = require('express')

const router = express.Router();
const books = require('../controllers/BookController');
const users = require('../controllers/AuthController');
const verifyToken = require('../middleware/auth');


router.get('/user/:id', verifyToken, users.findUserById);
router.post('/login', users.login);
router.post('/register', users.register);

router.get('/books', verifyToken, books.index);
router.get('/book/:id', verifyToken, books.findBookById);
router.post('/book', verifyToken, books.storeBook);
router.put('/book/:id', verifyToken, books.putBook);
router.delete('/book/:id', verifyToken, books.deleteBook);

module.exports = router;