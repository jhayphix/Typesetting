
# Define ANSI escape codes for colors
colors <- list(
  red = "\033[31m",
  green = "\033[32m",
  yellow = "\033[33m",
  blue = "\033[34m",
  white = "\033[97m",
  cyan = "\033[36m",
  reset = "\033[0m"
)

# Function to print colored text
print_colored <- function(text, color) {
  cat(paste0(colors[[color]], text, colors$reset))
}

# Function to print line
hline <- function(color="cyan", type="-"){
  type_dash <- "-------------*********-----------------"
  print_colored(type_dash, color)
  cat('\n')
}