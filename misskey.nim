import strutils
import httpClient, json

let client = newHttpClient()
client.headers = newHttpHeaders({ "Content-Type": "application/json" })

proc getNotes*(token: string, userId: string, limit: int, sinceId: string, untilId: string) =
  echo token & userId & limit.intToStr() & sinceId & untilId

proc getNotes*(token: string, userId: string, limit: int): JsonNode =
  let body = %*{
    "i": token,
    "userId": userId,
    "limit": limit
  }
  echo body
  let response = client.request("https://misskey.m544.net/api/users/notes", httpMethod = HttpPost, body = $body)
  echo response.status
  return response.body.parseJson()