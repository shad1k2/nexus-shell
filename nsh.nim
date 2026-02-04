import os, strutils, osproc, terminal, net, posix
import tools/sysinfo, tools/nproc, tools/calc, tools/editor, tools/ghost

proc main() =
  eraseScreen()
  setCursorPos(0, 0)

  while true:
    let cwd = getCurrentDir().replace(getHomeDir(), "~")
    
    # --- ИЗМЕНЕНИЕ ТУТ: Проверяем статус из модуля ghost для промпта ---
    let ghostLabel = if ghost.inGhostMode: "\e[1;31m[GHOST]\e[0m " else: ""
    
    # Добавляем ghostLabel в вывод
    stdout.write(ghostLabel & "\e[1;35m[shad1k1@nexus \e[0m" & cwd & "\e[1;35m]# \e[0m")
    stdout.flushFile()

    let input = stdin.readLine().strip()
    if input == "": continue

    let args = input.splitWhitespace()
    let cmd = args[0]

    case cmd
    of "exit": quit(0)
    of "fetch": showFetch()
    of "monitor", "nproc": showMonitor()
    of "edit":
      let file = if args.len > 1: args[1] else: ""
      nEdit(file)
      eraseScreen()
      setCursorPos(0, 0)
    of "calc":
      let exp = if args.len > 1: args[1..^1].join(" ") else: ""
      nCalc(exp)
    of "cd":
      let dest = if args.len > 1: args[1] else: getHomeDir()
      try: setCurrentDir(dest)
      except: echo "nsh: directory not found"
    of "clear":
      eraseScreen()
      setCursorPos(0, 0)
    of "whoami":
      echo getEnv("USER")
    of "update":
      echo "Updating package manager"
      discard execShellCmd("sudo n-get update")
    of "help":
      echo "Available commands: \n"
      echo "Exit: Exiting from nsh \n"
      echo "Fetch: Lite fastfetch analog integrated to shell \n"
      echo "Monitor/nproc: Start system resource monitor \n"
      echo "Edit [file]: Edit file with nEdit - nexus analog of GNU Nano \n"
      echo "Calc: Calculate a mathematical expression with nCalc, calc for help \n"
      echo "Cd: Change directory \n"
      echo "Clear: Clears terminal \n"
      echo "Whoami: Displays your uid \n"
      echo "Update: Update system via n-get \n"
      echo "Help: Shows this \n"
      echo "Ghost: Ghost module with Tor proxy, ghost for help \n"
      echo "Also supports GNU Bash commands \n"

    of "ghost":
      if args.len > 1:
        case args[1]
        of "on": ghost.toggleGhost(true)
        of "off": ghost.toggleGhost(false)
        of "status": 
          let s = if ghost.inGhostMode: "ACTIVE" else: "INACTIVE"
          echo "Ghost Mode is: ", s
        else: echo "Usage: ghost [on|off|status]"
      else:
        echo "Usage: ghost [on|off|status]"

    else:
        let finalCmd = if ghost.inGhostMode: "torsocks " & input else: input
        discard execShellCmd(finalCmd)
main()
