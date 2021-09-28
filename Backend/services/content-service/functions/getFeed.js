import { success, error } from "../../../libs/response";
import { getLatest } from "../../../repositories/contentRepository";

export default async function handler(event) {
  try {
    return success(await getLatest());
  }
  catch (err) {
    console.log(err);
    return error('encountered an error creating content');
  }
};
