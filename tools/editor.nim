import os, terminal, strutils

proc nEdit*(filename: string) =
  if filename == "":
    echo "Usage: edit <filename>"
    return

  var lines: seq[string] = @[]

  if fileExists(filename):
    let content = readFile(filename)
    if content.len > 0:
      lines = content.splitLines()

  if lines.len == 0:
    lines.add("")

  while true:
    eraseScreen()
    setCursorPos(0, 0)
    styledWriteLine(stdout, fgYellow, bgBlue, " Nexus Editor v0.1 | File: ", filename, " ")
    echo "Commands: :q (exit), :wq (save), :d <idx> (delete)\n"

    for i, line in lines:
      echo i, " | ", line

    stdout.write("\nline " & $lines.len & " > ")
    let input = stdin.readLine()

    if input == ":q":
      break
    elif input == ":wq":
      try:
        writeFile(filename, lines.join("\n"))
        echo "File saved."
        break
      except:
        echo "Error: Could not save file!"
        break
    elif input.startsWith(":d "):
      try:
        let idx = input[3..^1].strip().parseInt()
        if idx >= 0 and idx < lines.len:
          lines.delete(idx)
      except:
        discard
    else:
      if lines.len == 1 and lines[0] == "":
        lines[0] = input
      else:
        lines.add(input)
