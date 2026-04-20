const { CreateRecipeInput } = require("./recipe.types");

const createRecipe = async (data: typeof CreateRecipeInput) => {
    // todo : branch repository

    return {
        id: 1,
        ...data,
        createdAt: new Date(),
    };
};

module.exports = { createRecipe };