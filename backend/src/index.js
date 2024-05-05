import express from 'express';
import './conexion.js'

const app = express();
const port = 3000;

app.listen(port, () => {
    console.log(`Servidor en el puerto ${port}`)
})

