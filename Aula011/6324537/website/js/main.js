document.addEventListener('DOMContentLoaded', () => {
    const form = document.querySelector('#contactForm');
    const status = document.querySelector('#contactStatus');
    if (!form) return;

    form.addEventListener('submit', async (event) => {
        event.preventDefault();
        status.textContent = 'Enviando...';
        const endpoint = form.dataset.endpoint;

        const payload = {
            name: form.name.value.trim(),
            email: form.email.value.trim(),
            message: form.message.value.trim(),
        };

        try {
            const response = await fetch(endpoint, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(payload),
            });
            const data = await response.json();
            if (response.ok) {
                status.textContent = 'Mensagem enviada com sucesso!';
                form.reset();
            } else {
                status.textContent = data.message || 'Falha ao enviar mensagem.';
            }
        } catch (error) {
            console.error(error);
            status.textContent = 'Erro de conexão. Verifique o endpoint da API.';
        }
    });
});
