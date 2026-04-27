-- =====================================================
-- Database: saponify
-- Initial schema
-- =====================================================

-- Create the database
CREATE DATABASE IF NOT EXISTS saponify
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

-- Use the database
USE saponify;

-- =====================================================
-- Tables
-- =====================================================

-- Users table
CREATE TABLE IF NOT EXISTS users (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    lastname VARCHAR(20),
    firstname VARCHAR(30),
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Oils table
CREATE TABLE IF NOT EXISTS oils (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    sap_index_naoh DECIMAL(10, 5) NOT NULL,
    sap_index_koh DECIMAL(10, 5) NOT NULL,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Additives table
CREATE TABLE IF NOT EXISTS additives (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Recipes table
CREATE TABLE IF NOT EXISTS recipes (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNSIGNED NOT NULL,
    name VARCHAR(100) NOT NULL,
    method ENUM('SAF', 'hot_process') NOT NULL DEFAULT 'SAF',
    alkali_type ENUM('NaOH', 'KOH') NOT NULL DEFAULT 'NaOH',
    water_percentage DECIMAL(5, 2) NOT NULL CHECK (water_percentage BETWEEN 0 AND 100),
    superfat_percentage DECIMAL(5, 2) NOT NULL CHECK(superfat_percentage BETWEEN 0 AND 100),
    superfat_mode ENUM('lye_discount', 'trace_addition') NOT NULL DEFAULT 'lye_discount',
    citric_acid_g DECIMAL(10, 2) UNSIGNED,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Recipe oils table
CREATE TABLE IF NOT EXISTS recipe_oils (
    recipe_id INT UNSIGNED NOT NULL,
    oil_id INT UNSIGNED NOT NULL,
    percentage DECIMAL(5, 2) NOT NULL CHECK (percentage BETWEEN 0 AND 100),

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (recipe_id, oil_id),
    FOREIGN KEY (recipe_id) REFERENCES recipes(id) ON DELETE CASCADE,
    FOREIGN KEY (oil_id) REFERENCES oils(id)
);

-- Recipe superfat oils table
CREATE TABLE IF NOT EXISTS recipe_superfat_oils (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    recipe_id INT UNSIGNED NOT NULL,
    oil_id INT UNSIGNED NOT NULL,
    weight_g DECIMAL(10, 2) UNSIGNED NOT NULL,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (recipe_id) REFERENCES recipes(id) ON DELETE CASCADE,
    FOREIGN KEY (oil_id) REFERENCES oils(id)
);

-- Recipe additives table
CREATE TABLE IF NOT EXISTS recipe_additives (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    recipe_id INT UNSIGNED NOT NULL,
    additive_id INT UNSIGNED NOT NULL,
    weight_g DECIMAL(10, 2) UNSIGNED NOT NULL,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (recipe_id) REFERENCES recipes(id) ON DELETE CASCADE,
    FOREIGN KEY (additive_id) REFERENCES additives(id)
);