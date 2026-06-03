document.addEventListener('DOMContentLoaded', () => {
    console.log("🚀 Portfólio carregado via CloudFront CDN.");
    const form = document.querySelector('form');
    if (form) {
        form.addEventListener('submit', (e) => {
            console.log("Invocando API Gateway...");
        });
    }
});
