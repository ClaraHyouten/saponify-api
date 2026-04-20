const { z } = require('zod');

const createRecipeSchema = z.object({
    userId: z.number().int().positive(),
    name: z.string().min(1),
    totalOilWeight: z.number().positive(),
    waterPercentage: z.number().min(0).max(100),
    oils: z.array(
        z.object({
            oilId: z.number().int().positive(),
            percentage: z.number().min(0).max(100),
        })
    ).min(1),
});

module.exports = { createRecipeSchema };