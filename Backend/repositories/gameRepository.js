import { builder, tableNames } from '../libs/pgsql';
import { v4 as uuidv4 } from 'uuid';


export async function createGame(game) {
  const insertRec = {
    id: uuidv4(),
    name: game.name,
    backgroundcolor: game.backgroundColor || null,
    wallpaper: game.blobReference || null,
  };

  await builder(tableNames.games).insert(insertRec);
  return insertRec.id;
}

export async function getByName(name) {
  console.log(name);
  return builder(tableNames.games).where('name', name).first();
}