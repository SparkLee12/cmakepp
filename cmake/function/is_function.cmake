#returns true if the the val is a function string or a function file
function(is_function result val)

	is_function_string(is_func "${val}")
	if(is_func)
		return_value(string)
	endif()
	is_function_cmake(is_func "${val}")
	if(is_func)
		return_value(cmake)
	endif()
	
	if(is_function_called)
		return_value(false)
	endif()
	is_function_file(is_func "${val}")
	if(is_func)		
		return_value(file)
	endif()
	set(is_function_called true)
	is_function_ref(is_func "${val}")
	if(is_func)
		return_value(${is_func})
	endif()


	return_value(false)
endfunction()