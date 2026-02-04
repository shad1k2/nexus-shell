import strutils, math

proc nCalc*(exp: string) =
  # Простейший парсер для примера. 
  # В будущем тут будет полноценный алгоритм "обратной польской нотации"
  try:
    if "+" in exp:
      let parts = exp.split("+")
      echo "Result: ", parts[0].strip().parseFloat() + parts[1].strip().parseFloat()
    elif "-" in exp:
      let parts = exp.split("-")
      echo "Result: ", parts[0].strip().parseFloat() - parts[1].strip().parseFloat()
    elif "*" in exp:
      let parts = exp.split("*")
      echo "Result: ", parts[0].strip().parseFloat() * parts[1].strip().parseFloat()
    else:
      echo "Currently nCalc v0.1 supports: + - *"
  except:
    echo "Error: Invalid math expression"
