import { Pool } from 'pg';
import knex from 'knex';
const {
    DATABASE_USER,
    DATABASE_PASS,
    DATABASE_HOST,
    DATABASE_NAME,
    STAGE,
} = process.env;

const connection = {
    user: DATABASE_USER,
    host: DATABASE_HOST,
    database: DATABASE_NAME + '_' + STAGE,
    password: DATABASE_PASS,
    port: 5432,
};

const knexOptions = {
    client: 'pg',
    connection,
};

const pool = new Pool(connection);
export const builder = knex(knexOptions);

export const tableNames = Object.freeze({
    games: 'games',
    users: 'users',
    vidya_content: 'vidya_content',
});

export async function executeAsync(query, parameters) {
    try {
        // to get rows await result.rows in consuming function
        if (parameters) {
            return pool.query(query, parameters);
        }

        return pool.query(query);
    } catch (e) {
        console.error(`Database Connection Error, ${e}`);
        throw new Error('Encountered an error with query execution');
    }
}

export const execute = async (query, parameters) => {
    let result = null;

    try {
        result = await pool.query(query.toString(), parameters);
    } catch (e) {
        console.error(`Database Connection Error, ${e}`);
        throw new Error('Encountered an error with query execution');
    }
    return result.rows;
};