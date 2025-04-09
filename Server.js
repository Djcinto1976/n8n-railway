module.exports = function(app) {
    app.set('trust proxy', 1); // Habilita a confiança no cabeçalho X-Forwarded-For
};
