const app = require('fastify')({
    logger: true
});

app.get('/', async (request: any, reply: any) => {
    return { message: 'API running ✅' }
});

const start = async () => {
    try {
        await app.listen({ port: 3000, host: '::1' }, (error: any, address: string) => {
            if (error) {
                app.log.error(error);
                process.exit(1);
            }
            app.log.info(`server listening on ${address}`);
        });
    } catch (error) {
        app.log.error(error);
        process.exit(1);
    }
};

start();