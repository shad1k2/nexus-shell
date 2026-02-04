import os, terminal, strformat, posix

proc nls*(path: string = ".") =
  echo "\n--- Directory Listing: ", path, " ---"
  for kind, file in walkDir(path):
    let color = if kind == pcDir: fgBlue else: fgGreen
    let info = getFileInfo(file)
    stdout.styledWrite(color, f"{lastPathPart(file):<20}")
    stdout.write(f" | {info.size:>8} bytes\n")
  echo ""
