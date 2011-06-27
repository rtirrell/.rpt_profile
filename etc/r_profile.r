library(stringr)
options(max.print = 1000)
options(stringsAsFactors = TRUE)

##
# Miscellaneous output functions.
#
csprintf <- function(...) {
  cat(sprintf(...))
}

psprintf <- function(...) {
  print(sprintf(...))
}

wsprintf <- function(...) {
  warning(sprintf(...))
}

ssprintf <- function(...) {
  stop(sprintf(...))
}

##
# Miscellaneous replacement functions.
#

# Replace '.' with '_'.
dot_under <- function(value) {
  str_replace_all(value, fixed('.'), fixed('_'))
}

# Replace '.' with ' '.
dot_space <- function(value) {
  str_replace_all(value, fixed('.'), fixed(' '))
}

# Replace ' ' with '_'.
space_under <- function(value) {
  str_replace_all(value, '\\s+', '_')
}

# Replace '_' with ' '.
under_space <- function(value) {
  str_replace_all(value, '_', ' ')
}

# Replace, e.g., abs.log.value with abs(log(value)).
to_paren <- function(value, char) {
  ndots <- vapply(str_locate_all(value, fixed(char)), nrow, integer(1))
  str_c(str_replace_all(value, fixed(char), fixed('(')), str_dup(')', ndots))
}
dot_paren <- function(value) {
  to_paren(value, '.')
}
under_paren <- function(value) {
  to_paren(value, '_')
}

# Remove all non alphanumeric characters and collapse whitespace.
normalize <- function(value) {
  single_space(str_replace_all(value, '[^A-Za-z0-9 ]+', ''))
}

# Capitalize a value.
capitalize <- function(value) {
  str_c(
    toupper(str_sub(value, 1, 1)), 
    str_sub(value, 2, str_length(value))
  )
}

# Convert a string (e.g. an identifier like 'my_name' or 'my.name') 
# to a proper form.
properize <- function(value) {
  capitalize(under_space(value))
}

# Format a tuple, e.g. for use with the IN operator in SQL.
format_tuple <- function(values) {
  if (is.character(values)) 
    values <- sprintf("'%s'", values)
  sprintf('(%s)', str_c(values, collapse = ', '))
}

# Replace any number of all types of whitespace (space, tab, newline) 
# with a single space.
single_space <- function(value) {
  str_replace_all(value, '\\s+', ' ')
}

# Replace commas and reverse a string.
reverse_commas <- function(value) {
  single_space(rev(str_replace_all(value, fixed(','), ' ')))
}

get_initials <- function(value) {
  toupper(vapply(str_split(normalize(value), '\\s+'), function(split_value) {
    str_c(str_sub(split_value, 1, 1), collapse = '')
  }, character(1)))
}

# Break a string with newlines.
str_break <- function(values, max_length = 40) {
  lengths <- str_length(values)
  spaces <- str_locate_all(values, '\\s+')
  vapply(seq_along(values), function(i) {
    if (lengths[i] > max_length) {
      which_after <- which(spaces[[i]][, 1] >= floor(lengths[i] / 2))[1]
      str_c(
        str_sub(values[i], end = spaces[[i]][which_after, 1] - 1), '\n',
        str_sub(values[i], spaces[[i]][which_after, 2] + 1)
	    )
    } else
      values[i]
  }, character(1))
}
    


##
# Project utility functions.
#

##
# Files:
# - boot.r is intended to be sourced only once, and contains (e.g.)
#   library() statements, database setup.
# - env.r contains constants.
# - db.r contains database-related functions.
# - load.r loads datasets from disk or database.
# - func.r contains functions (go figure).
#
# Directories:
# - data/ contains data and plots.
# - do/ contains core code.
# - dx/ contains diagnostic and similar code.
# - load/ contains dataset-loading code (from database or filesystem).
# - oo/ contains once-off code, e.g., to build a database or precompute
#   a lookup table.
# - Other names are subprojects.
BOOT_FILENAMES <- c('env.r', 'boot.r', 'func.r', 'db.r', 'load.r')

# Source every file in a directory.
source_directory <- function(directory) {
  if (missing(directory))
    directory <- getwd()
  for (file in Sys.glob(file.path(directory, '*.r')))
    source(file)
}

# Re-source all non-executing code from the given directory downward.
resource <- function(directory) {
	boot(directory, boot_for = c('env.r', 'func.r', 'db.r'))
}

# Reload and resource all non-boot code from the given directory downward.
reload <- function(directory) {
  boot(directory, boot_for = c('env.r', 'func.r', 'db.r', 'load.r'))
}

# Initialize (or reinitialize) the project environment.
# - boot_for is a vector of filenames to source, 
#   or a test to apply to a filename.
boot <- function(directory, boot_for = BOOT_FILENAMES) {
	if (missing(directory)) 
    directory <- getwd()

  if (is.character(boot_for)) {
    for (filename in boot_for) {
      if (file.exists(file.path(directory, filename))) 
        source(file.path(directory, filename))
    }
  } 

  for (file in list.files(directory, full.names = TRUE)) {
    if (str_sub(file, -4) == 'data')
      next
    if (is.function(boot_for) && file_test('-f', file) && boot_for(file)) {
      csprintf('RUNNING %s.\n', file)
      source(file)
    }
    if (file_test('-d', file))
	    boot(file, boot_for)
	}
}

# Run a file after re-sourcing from the current directory.
run <- function(file) {
  resource()
  source(file)
}

# Run all do_*.r files from the given directory downward, in any order.
do_all <- function(directory) {
  resource(directory)
  boot_test <- function(file) {
    str_detect(file, 'do/.*\\.r')
  }
  boot(directory, boot_test)
}

## 
# Functional utilities.
#

# Memoize a function, returning precomputed values when the same arguments
# are passed.
memoize_func <- function(func) {
  require(digest)
	cache <- new.env()
	function(...) {
		hash <- digest(list(...))
		if (!exists(hash, env = cache, inherits = FALSE)) 
			assign(hash, func(...), env = cache)
		get(hash, env = cache)
	}
}

# Memoize a list, using an expression as the key. If that expression has
# already been evaluated, return the stored result.
memoize_list <- function(data) {
	function(name, expr) {
		if (missing(name)) 
      return(data)
		
		name <- as.character(name)
		if (!name %in% names(data)) 
			data[[name]] <<- eval(expr, env = parent.frame())
		
		data[[name]]
	}
}

##
# Odds and ends.
#

# Limit a data frame to the first limit rows, according to the given
# sorting field and sorting order.
limit_ordered <- function(dat, limit, attribute, decreasing = TRUE) {
  dat[order(dat[[attribute]], decreasing = decreasing)[seq_len(limit)], ]
}

# Suppress the unnecessary file save messages from ggplot.
save_ggplot <- function(...) {
  suppressMessages(ggsave(...))
}

get_query <- function(connection, statement, ...) {
  tryCatch(
    dbGetQuery(connection, statement, ...), 
    error = function(e) {
      cat(statement, '\n')
      stop(e)
    }
  )
}
