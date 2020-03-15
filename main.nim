import misskey
import json
import yaml/serialization, streams

type Settings = object
  token: string;

proc main() =
  var settings: Settings;
  var s = newFileStream("settings.yaml")
  load(s, settings)
  let notes = getNotes(settings.token, "5acddf5fcd7aebd97984769a", 5).getElems();
  
  for i, note in notes:
    echo note

main()