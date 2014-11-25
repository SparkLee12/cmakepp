# 
function(project_register name)
  map_new()
  ans(pmap)
  map_set(global project_map ${pmap})
  function(project_register name)
    map_new()
    ans(cmake_current_project)
    map_set(${cmake_current_project} name "${name}")
    map_set(${cmake_current_project} directory "${CMAKE_CURRENT_LIST_DIR}")
    map_append(global projects ${cmake_current_project})
    map_append(global project_names ${name})
    map_tryget(global project_map)
    ans(pmap)
    map_set(${pmap} ${name} ${cmake_current_project})
  endfunction()
  project_register(${name} ${ARGN})
  return_ans()
endfunction()

# returns the project object identified by name
function(project_object)
  set(name ${ARGN})
  if(NOT name)
    # set to current project name
    set(name ${project_name})
    if(NOT name)
      set(name "${PROJECT_NAME}")
    endif()
  endif()
  
  map_tryget(global project_map)
  ans(res)
  if(NOT res)
    return()
  endif()
  map_tryget(${res} ${name})
  return_ans()
endfunction()

# returns the names of all project
macro(project_list)
  map_tryget(global project_names)
endmacro()