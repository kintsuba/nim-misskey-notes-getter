# This is just an example to get you started. A typical binary package
# uses this file as the main entry point of the application.
import misskey
import os, json
import yaml/serialization, streams, strutils

type Settings = object
  token: string
  notesCount: int
  wait: int
  userId: string

proc main() =
  var settings: Settings;
  var s = newFileStream("settings.yaml")
  load(s, settings)

  var
    count = 0
    getNotesCount = settings.notesCount
    lastNotesId: string
  
  while count < getNotesCount:
    let notes = if count == 0:
      getNotes(settings.token, settings.userId, 100).getElems()
    else:
      getNotes(settings.token, settings.userId, 100, lastNotesId).getElems()

    var text: string
    for note in notes:
      text = text & note["text"].getStr & "\n"
      
    block:
      let f: File = if count == 0:
        open("notes.txt", FileMode.fmWrite)
      else:
        open("notes.txt", FileMode.fmAppend)
      defer:
        close(f)
      f.writeLine(text)

    lastNotesId = notes[99]["id"].getStr
    count += 100
    echo count.intToStr & " / " & getNotesCount.intToStr
    sleep(settings.wait)
main()