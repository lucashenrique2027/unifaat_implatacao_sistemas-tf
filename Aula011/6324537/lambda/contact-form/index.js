const AWS = require('aws-sdk');
const dynamo = new AWS.DynamoDB.DocumentClient();
const ses = new AWS.SES({ region: process.env.AWS_REGION || 'us-east-1' });

const TABLE_NAME = process.env.CONTACT_TABLE || 'ContactMessages';
const SOURCE_EMAIL = process.env.SOURCE_EMAIL || 'no-reply@seu-dominio.com';
const DESTINATION_EMAIL = process.env.DESTINATION_EMAIL || 'seu-email@dominio.com';

exports.handler = async (event) => {
    console.log('Evento recebido:', JSON.stringify(event, null, 2));
    const body = typeof event.body === 'string' ? JSON.parse(event.body) : event.body;

    const item = {
        id: `${Date.now()}-${Math.floor(Math.random() * 10000)}`,
        name: body.name || 'Anônimo',
        email: body.email || 'sem-email@dominio.com',
        message: body.message || '',
        createdAt: new Date().toISOString(),
    };

    try {
        await dynamo.put({ TableName: TABLE_NAME, Item: item }).promise();

        const params = {
            Source: SOURCE_EMAIL,
            Destination: { ToAddresses: [DESTINATION_EMAIL] },
            Message: {
                Subject: { Data: `Novo contato de ${item.name}` },
                Body: {
                    Text: {
                        Data: `Nome: ${item.name}\nEmail: ${item.email}\nMensagem:\n${item.message}`
                    }
                }
            }
        };

        await ses.sendEmail(params).promise();

        return {
            statusCode: 200,
            headers: { 'Access-Control-Allow-Origin': '*', 'Content-Type': 'application/json' },
            body: JSON.stringify({ message: 'Contato enviado com sucesso.' }),
        };
    } catch (error) {
        console.error('Erro no Lambda:', error);
        return {
            statusCode: 500,
            headers: { 'Access-Control-Allow-Origin': '*', 'Content-Type': 'application/json' },
            body: JSON.stringify({ message: 'Erro interno no envio do contato.' }),
        };
    }
};
