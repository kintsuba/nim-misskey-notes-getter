import strutils
import httpClient, json

let client = newHttpClient()
client.headers = newHttpHeaders({ "Content-Type": "application/json" })

proc requestMisskey*(url: string, httpMethod: HttpMethod, body: string): JsonNode =
  let response = client.request("https://misskey.m544.net/api/users/notes", httpMethod = HttpPost, body = $body)
  return response.body.parseJson()

proc getNotes*(token: string, userId: string, limit: int, sinceId: string, untilId: string): JsonNode =
  let body = %*{
    "i": token,
    "userId": userId,
    "limit": limit,
    "sinceId": sinceId,
    "untilId": untilId
  }
  return requestMisskey("https://misskey.m544.net/api/users/notes", httpMethod = HttpPost, body = $body)

proc getNotes*(token: string, userId: string, limit: int, untilId: string): JsonNode =
  let body = %*{
    "i": token,
    "userId": userId,
    "limit": limit,
    "untilId": untilId
  }
  return requestMisskey("https://misskey.m544.net/api/users/notes", httpMethod = HttpPost, body = $body)

proc getNotes*(token: string, userId: string, limit: int): JsonNode =
  let body = %*{
    "i": token,
    "userId": userId,
    "limit": limit
  }
  return requestMisskey("https://misskey.m544.net/api/users/notes", httpMethod = HttpPost, body = $body)