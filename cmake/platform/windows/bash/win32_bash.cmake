# wraps the the win32 bash shell if available (Cygwin)
function(win32_bash)
  find_package(Cygwin )
  if(NOT Cygwin_FOUND)
    message(FATAL_ERROR "Cygwin was not found on your system")
  endif()
  wrap_exectuable(win32_bash "${Cygwin_EXECUTABLE}")
  win32_bash(${ARGN})
  return_ans()
endfunction()
