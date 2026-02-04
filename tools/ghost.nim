import os, osproc, strutils

var inGhostMode* = false 

proc setProxy(enable: bool) =
  if enable:
    putEnv("http_proxy", "socks5://127.0.0.1:9050")
    putEnv("https_proxy", "socks5://127.0.0.1:9050")
    putEnv("ALL_PROXY", "socks5://127.0.0.1:9050")
  else:
    delEnv("http_proxy")
    delEnv("https_proxy")
    delEnv("ALL_PROXY")

proc toggleGhost*(status: bool) =
  if status == inGhostMode: return

  if status:
    if execCmd("systemctl is-active --quiet tor") != 0:
      discard execCmd("sudo systemctl start tor")
    setProxy(true)
    inGhostMode = true
    echo "[!] Ghost Mode: ACTIVATED"
  else:
    setProxy(false)
    inGhostMode = false
    echo "[!] Ghost Mode: DEACTIVATED"

proc getStatusString*(): string =
 return if inGhostMode: " [GHOST] " else: " "
