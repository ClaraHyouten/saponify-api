const env = require('../config/env');
const dbPlugin = require('../plugins/db');
const { recipeRoutes } = require('../modules/recipes/recipe.routes');

const app = require('fastify')({
    logger: true
});

app.get('/', async (request: any, reply: any) => {
    return { message: 'API running ✅' }
});


const start = async () => {
    try {
        await app.register(dbPlugin);
        await app.register(recipeRoutes);
        
        await app.listen({ port: env.PORT, host: '::1' }, (error: any, address: string) => {
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