
function(config_function config_obj config_definition key)
  if("${key}"  STREQUAL "*")
    return(${config_obj})
  endif()
  if("${key}" STREQUAL "help")
    list_structure_print_help(${config_definition})
    return()
  endif()
  if("${key}" STREQUAL "print" )
    json_print(${config_obj})
    return()
  endif()
  map_get("${config_obj}" "${key}")
  return_ans()
endfunction()