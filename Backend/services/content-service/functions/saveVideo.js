import { success, error } from "../../../libs/response";
import { createContent } from "../../../repositories/contentRepository";
import { createGame, getByName } from "../../../repositories/gameRepository";

export default async function handler(event) {
  try {
    let gameId;
    const body = JSON.parse(event.body);
    console.log(body);

    const game = await getByName(body.game);
    if (!game) {
      gameId = await createGame({ name: body.game });
    }
    else {
      gameId = game.id;
    }

    const contentId = await createContent(body, gameId);

    return success(contentId);
  }
  catch (err) {
    console.log(err);
    return error('encountered an error creating content');
  }
};
