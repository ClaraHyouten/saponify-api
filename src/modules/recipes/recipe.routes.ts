const { FastifyInstance } = require("fastify");
const { createRecipe } = require("./recipe.controller");

const recipeRoutes = (fastify: typeof FastifyInstance) => {
    fastify.post("/recipes", createRecipe);
};

module.exports = { recipeRoutes };