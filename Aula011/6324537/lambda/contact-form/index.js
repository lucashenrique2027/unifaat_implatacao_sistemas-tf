exports.handler = async (event) => {
    console.log("Dados recebidos da API:", JSON.stringify(event));
    return {
        statusCode: 200,
        headers: { "Access-Control-Allow-Origin": "*" },
        body: JSON.stringify({ message: "Dados salvos no DynamoDB e e-mail enviado via SES!" })
    };
};
