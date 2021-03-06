# changes the current directory 
function(cd)
  set(args ${ARGN})
  list_extract_flag(args --create)
  ans(create)
  list_extract_flag(args --force)
  ans(force)
  path("${args}")
  ans(path)
 # message("cd ${path}")
  if(NOT IS_DIRECTORY "${path}" AND NOT force)
    if(NOT create)
      message(FATAL_ERROR "directory '${path}' does not exist")
      return()
    endif()
    mkdir("${path}")
  endif()
  address_set(__global_cd_current_directory "${path}")

  return_ref(path)
endfunction()