// server.js
const express = require('express')
const { exec } = require('child_process')
const multer = require('multer')
const app = express()
const upload = multer({ dest: 'uploads/' })

app.post('/upload', upload.single('file'), (req, res) => {
  const filepath = req.file.path
  exec(`btfs add ${filepath}`, (err, stdout) => {
    if (err) return res.status(500).send('BTFS upload failed')
    const match = stdout.match(/added (\S+)/)
    if (match) {
      const cid = match[1]
      res.json({ btfs: `btfs://${cid}` })
    } else {
      res.status(500).send('CID not found')
    }
  })
})

app.listen(3000, () => console.log('Uploader running on http://localhost:3000'))
