function(cmakelists_serialize cmakelists)
    map_tryget(${cmakelists} begin)
    ans(begin)
    cmake_token_range_serialize("${begin}")
    ans(content)
    return_ref(content)
endfunction()
