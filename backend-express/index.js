const express = require("express"); //import expres
const prisma = require("./prisma/client");
const router = require("./routes");

const port = 3000;
const app = express(); //init ap

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use('/api', router);


app.listen(port, () => {
    console.log(`Server started on port ${port}`);
});
