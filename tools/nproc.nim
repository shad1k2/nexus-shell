import os, strutils, terminal, math

# Выносим переменную на уровень модуля и помечаем как {.threadvar.}
# или просто создаем глобально, чтобы обработчик её видел.
var running {.volatile.}: bool = true

proc drawBar(label: string, percent: float, color: ForegroundColor) =
  let width = 30
  let filled = int(percent / 100.0 * width.float)
  stdout.write(label & " [")
  stdout.setForegroundColor(color)
  stdout.write("█".repeat(clamp(filled, 0, width)))
  stdout.setForegroundColor(fgWhite)
  stdout.write("-".repeat(clamp(width - filled, 0, width)))
  stdout.write("] " & formatFloat(percent, ffDecimal, 1) & "%\n")

# Обработчик нажатия Ctrl+C
proc handleCtrlC() {.noconv.} =
  running = false

proc showMonitor*() =
  hideCursor()
  running = true # Сбрасываем в true при каждом входе
  
  # Устанавливаем обработчик
  setControlCHook(handleCtrlC)

  while running:
    eraseScreen()
    setCursorPos(0, 0)
    styledWriteLine(stdout, fgCyan, "=== NEXUS RESOURCE MONITOR ===")
    styledWriteLine(stdout, fgYellow, "Press Ctrl+C to return to Nexus Shell\n")

    # RAM
    try:
      let memData = readFile("/proc/meminfo").splitLines()
      let total = memData[0].splitWhitespace()[1].parseFloat()
      let avail = memData[2].splitWhitespace()[1].parseFloat()
      drawBar("Memory:", ((total - avail) / total) * 100.0, fgMagenta)
    except:
      echo "Failed to read Memory data"

    # CPU
    try:
      let load = readFile("/proc/loadavg").splitWhitespace()[0].parseFloat() * 10.0
      drawBar("CPU Load:", clamp(load, 0.0, 100.0), fgGreen)
    except:
      echo "Failed to read CPU data"

    stdout.flushFile()
    sleep(800)
  
  showCursor()
  # Возвращаем стандартное поведение Ctrl+C (выход из шелла)
  setControlCHook(proc() {.noconv.} = quit(0))
