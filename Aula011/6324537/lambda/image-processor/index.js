const AWS = require('aws-sdk');

exports.handler = async (event) => {
    console.log('Evento S3 recebido para processamento de imagem:', JSON.stringify(event, null, 2));
    // TODO: adicionar lógica de redimensionamento com Sharp ou outro pacote apropriado.
    return {
        statusCode: 200,
        body: JSON.stringify({ message: 'Processamento de imagem recebido.' }),
    };
};
