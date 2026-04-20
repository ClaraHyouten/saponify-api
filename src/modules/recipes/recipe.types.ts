export type Recipe = {
    id: number;
    userId: number;
    name: string;
    totalOilWeight: number;
    waterPercentage: number;
    createdAt: Date;
};

export type RecipeOil = {
    recipeId: number;
    oilId: number;
    percentage: number;
};

export type CreateRecipeInput = {
    userId: number;
    name: string;
    totalOilWeight: number;
    waterPercentage: number;
    oils: Array<{
        oilId: number;
        percentage: number;
    }>;
};