import { util } from "@aws-appsync/utils";
import { scan } from "@aws-appsync/utils/dynamodb";

export function request(ctx) {
  const { limit, nextToken } = ctx.args;
  return scan({
    limit,
    nextToken,
    filter: {
      expression: "(#user_id,:sub)",
      expressionNames: { "#user_id": "userId" },
      expressionValues: {
        ":sub": { S: ctx.identity.sub },
      },
    },
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
