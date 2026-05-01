const mysql = require('mysql2/promise');
const fp = require('fastify-plugin');
const env = require('../config/env');

const dbPlugin = async (fastify: any, options: any) => {
    const pool = mysql.createPool({
        host: env.DB_HOST,
        port: env.DB_PORT,
        user: env.DB_USER,
        password: env.DB_PASSWORD,
        database: env.DB_NAME,

        waitForConnections: true,
        connectionLimit: 10,
        queueLimit: 0,
    });

    await pool.query('SELECT 1');
    fastify.log.info(`Database connected on ${env.DB_PORT}`);

    fastify.decorate('db', pool);

    fastify.addHook('onClose', async () => {
        await pool.end();
    });
};

module.exports = fp(dbPlugin);