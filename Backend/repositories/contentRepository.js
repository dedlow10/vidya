import { builder, tableNames } from '../libs/pgsql';
import { v4 as uuidv4 } from 'uuid';


export async function createContent(content, gameId) {
    const insertRec = {
        id: uuidv4(),
        game_id: gameId,
        title: content.title,
        blob_reference: content.blobReference,
        created_date: new Date().toISOString(),
        modified_date: new Date().toISOString(),
    };

    await builder(tableNames.vidya_content).insert(insertRec);
    return insertRec.id;
}

export async function getLatest() {
    return builder(tableNames.vidya_content)
        .join(tableNames.games, 'game_id', tableNames.games + '.id')
        .limit(20)
        .orderBy("created_date", "desc");
}