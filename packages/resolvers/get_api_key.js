import { util } from "@aws-appsync/utils";
import { get } from "@aws-appsync/utils/dynamodb";

export function request(ctx) {
  const { id } = ctx.args;
  const key = { id };
  return get({
    key,
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
  return result;
}
