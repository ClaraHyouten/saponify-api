const { FastifyRequest, FastifyReply } = require("fastify");
const { createRecipeSchema } = require("./recipe.schema");
const recipeService = require("./recipe.service");

const createRecipe = async (request: typeof FastifyRequest, reply: typeof FastifyReply) => {
    const parsedBody = createRecipeSchema.safeParse(request.body);

    if (!parsedBody.success) {
        return reply.status(400).send({
            error: "Invalid input",
            details: parsedBody.error.format(),
        });
    }

    const result = await recipeService.createRecipe(parsedBody.data);

    return reply.status(201).send(result);
};

module.exports = { createRecipe };