import misskey
import os, json
import yaml/serialization, streams

type Settings = object
  token: string;

proc main() =
  var settings: Settings;
  var s = newFileStream("settings.yaml")
  load(s, settings)
  const meimeiToken = "5acddf5fcd7aebd97984769a"

  var
    getNotesCount = 300
    lastNotesId: string
  
  while getNotesCount > 0:
    let notes = if lastNotesId == "":
      getNotes(settings.token, meimeiToken, 100).getElems()
    else:
      getNotes(settings.token, meimeiToken, 100, lastNotesId).getElems()

    var text: string
    for note in notes:
      text = text & note["text"].getStr & "\n"
      
    block:
      let f: File = if lastNotesId == "":
        open("notes.txt", FileMode.fmWrite)
      else:
        open("notes.txt", FileMode.fmAppend)
      defer:
        close(f)
      f.writeLine(text)

    lastNotesId = notes[99]["id"].getStr
    getNotesCount -= 100
    sleep(10000)
main()