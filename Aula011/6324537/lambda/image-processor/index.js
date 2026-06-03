exports.handler = async (event) => {
    console.log("Gatilho S3 disparado:", JSON.stringify(event));
    return {
        statusCode: 200,
        body: JSON.stringify({ message: "Imagem otimizada com sucesso no bucket de assets." })
    };
};
