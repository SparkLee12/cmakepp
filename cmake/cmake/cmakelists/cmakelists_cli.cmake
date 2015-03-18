
function(cmakelists_cli)

    set(args ${ARGN})
    list_pop_front(args)
    ans(command)

    list_extract_flags(args -v)
    ans(verbose)

    set(handler)
    if(verbose)
        event_addhandler(on_log_message "[](entry) message(FORMAT '{entry.function}: {entry.message}') ")
    endif()

    cmakelists_open("")
    ans(cmakelists)
        

    set(save false)
    if("${command}" STREQUAL "init")
        set(save true)
    elseif("${command}" STREQUAL "target")
        list_pop_front(args)
        ans(target_name)

        list_pop_front(args)
        ans(command)

        if("${target_name}" STREQUAL "add")
            set(target_name "${command}")
            set(command add)
        endif()

        if(NOT command)
            cmakelists_targets(${cmakelists} ${target_name})
            ans(result)
        elseif("${command}" STREQUAL add)
            list_extract(args target_type)
            set(save true)
            if(NOT target_type)
                set(target_type library)
            endif()
            map_capture_new(target_name target_type)
            ans(result)
            cmakelists_target_update(${cmakelists} ${result})
        elseif("${command}" STREQUAL source)
            cmakelists_target(${cmakelists} "${target_name}")
            ans(target)
            if(NOT target)
                message(FATAL_ERROR "no single target found for ${target_name}")
            endif()

            list_pop_front(args )
            ans(command)

            map_tryget(${target} target_source_files)
            ans(result)
            if(NOT command)

            else()  
                set(flag "--${command}")
                set(before ${result})
                list_modify(result ${flag} --remove-duplicates ${args})

                set(save true)
                map_set(${target} target_source_files ${result})
                cmakelists_target_update(${cmakelists} ${target})
                                
            endif()

        endif()

    endif()

    if(save)
        cmakelists_close(${cmakelists})
    endif()
    return_ref(result)
endfunction()
