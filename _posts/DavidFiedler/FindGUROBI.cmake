find_path(GUROBI_INCLUDE_DIRS
    NAMES gurobi_c.h
    HINTS ${GUROBI_DIR} $ENV{GUROBI_HOME}
    PATH_SUFFIXES include)
if(NOT GUROBI_INCLUDE_DIRS)
	message(FATAL_ERROR "Gurobi include dir not found. Gurobi home: $ENV{GUROBI_HOME}, Gurobi dir: ${GUROBI_DIR}, heade name: gurobi_c.h")
endif()

find_library(GUROBI_LIBRARY
    NAMES gurobi91 gurobi100
    HINTS ${GUROBI_DIR} $ENV{GUROBI_HOME}
    PATH_SUFFIXES lib)
if(NOT GUROBI_LIBRARY)
	message(FATAL_ERROR "Gurobi C library not found. Gurobi home: $ENV{GUROBI_HOME}, Gurobi dir: ${GUROBI_DIR}, library names: gurobi91")
endif()

if(CXX)
    if(MSVC)
        # determine Visual Studio year
        if(MSVC_TOOLSET_VERSION GREATER 141)
            set(MSVC_YEAR "2019")
        elseif(MSVC_TOOLSET_VERSION EQUAL 141)
            set(MSVC_YEAR "2017")
        elseif(MSVC_TOOLSET_VERSION EQUAL 140)
            set(MSVC_YEAR "2015")
        endif()

        if(MT)
            set(M_FLAG "mt")
        else()
            set(M_FLAG "md")
        endif()
        
        find_library(GUROBI_CXX_LIBRARY
            NAMES gurobi_c++${M_FLAG}${MSVC_YEAR}
            HINTS ${GUROBI_DIR} $ENV{GUROBI_HOME}
            PATH_SUFFIXES lib)
		if(NOT GUROBI_CXX_LIBRARY)
			message(FATAL_ERROR "Gurobi c++ library not found. Gurobi home: $ENV{GUROBI_HOME}, Gurobi dir: ${GUROBI_DIR}, library name: gurobi_c++${M_FLAG}${MSVC_YEAR}")
		endif()
		
        find_library(GUROBI_CXX_DEBUG_LIBRARY
            NAMES gurobi_c++${M_FLAG}d${MSVC_YEAR}
            HINTS ${GUROBI_DIR} $ENV{GUROBI_HOME}
            PATH_SUFFIXES lib)
    else()
        find_library(GUROBI_CXX_LIBRARY
            NAMES gurobi_c++
            HINTS ${PROJECT_SOURCE_DIR}
            PATH_SUFFIXES lib
			NO_CMAKE_ENVIRONMENT_PATH
			REQUIRED
		)
        set(GUROBI_CXX_DEBUG_LIBRARY ${GUROBI_CXX_LIBRARY})
		if(NOT GUROBI_CXX_LIBRARY)
			message(FATAL_ERROR "Gurobi c++ library not found. Gurobi home: $ENV{GUROBI_HOME}, Gurobi dir: ${GUROBI_DIR}, library name: gurobi_c++")
		endif()
    endif()
endif()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(GUROBI DEFAULT_MSG GUROBI_LIBRARY)
