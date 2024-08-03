const http = require('http');
const fs = require('fs');
const path = require('path');
const os = require('os');

const port = 5000;

const server = http.createServer((req, res) => {
  if (req.url === '/') {
    fs.readFile(path.join(__dirname, 'index.html'), (err, data) => {
      if (err) {
        console.error(err);
        res.statusCode = 500;
        res.end('Erreur interne du serveur');
      }


else {
        res.setHeader('Content-Type', 'text/html');
        res.end(data);
      }
    });
  } else if (req.url === '/hostname') {
    res.setHeader('Content-Type', 'text/plain');
    res.end(os.hostname());
  } else {
    res.statusCode = 404;
    res.end('Page non trouvée');
  }
});

server.listen(port, () => {
  console.log(`Serveur Node.js en écoute sur le port ${port}`);
});

