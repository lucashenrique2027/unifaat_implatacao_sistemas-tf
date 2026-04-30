cat > 6324537/application/backend/server.js << 'EOF'
const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json());

// Health check para o Checkpoint do Lab
app.get('/health', (req, res) => {
  res.json({ 
    status: 'healthy', 
    timestamp: new Date().toISOString(),
    server: 'AWS EC2 - Lab009'
  });
});

// Endpoint de exemplo para o portfólio
app.get('/api/info', (req, res) => {
  res.json({
    message: 'API do Lucas Henrique rodando no EC2!',
    ra: '6324537',
    region: process.env.AWS_REGION || 'us-east-1'
  });
});

app.listen(PORT, '0.0.0.0', () => {
  console.log(`Servidor rodando na porta ${PORT}`);
});
EOF