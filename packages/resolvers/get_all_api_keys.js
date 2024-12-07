import { util } from "@aws-appsync/utils";
import { scan } from "@aws-appsync/utils/dynamodb";

export function request(ctx) {
  const { filter, limit, nextToken } = ctx.args;
  console.log(filter);
  return scan({
    limit,
    nextToken,
    filter,
  });
}

export function response(ctx) {
  const { error, result } = ctx;
  if (error) {
    return util.appendError(error.message, error.type, result);
  }
  const { items = [], nextToken } = result;
  return { items, nextToken };
}
