
####### Expanded from @PACKAGE_INIT@ by configure_package_config_file() #######
####### Any changes to this file will be overwritten by the next CMake run ####
####### The input file was Config.cmake.in                            ########

get_filename_component(PACKAGE_PREFIX_DIR "${CMAKE_CURRENT_LIST_DIR}/../../../" ABSOLUTE)

macro(set_and_check _var _file)
  set(${_var} "${_file}")
  if(NOT EXISTS "${_file}")
    message(FATAL_ERROR "File or directory ${_file} referenced by variable ${_var} does not exist !")
  endif()
endmacro()

macro(check_required_components _NAME)
  foreach(comp ${${_NAME}_FIND_COMPONENTS})
    if(NOT ${_NAME}_${comp}_FOUND)
      if(${_NAME}_FIND_REQUIRED_${comp})
        set(${_NAME}_FOUND FALSE)
      endif()
    endif()
  endforeach()
endmacro()

####################################################################################

set(skip_this_file TRUE)
if(NOT pinocchio_FOUND)
  set(skip_this_file FALSE)
endif()
if(skip_this_file)
  foreach(component ${pinocchio_FIND_COMPONENTS})
    if(NOT "pinocchio_${component}_FOUND")
      set(skip_this_file FALSE)
    endif()
  endforeach()
endif()
if(skip_this_file)
  return()
endif()

set("pinocchio_INCLUDE_DIRS" "/home/glxrobot/catkin/install/include")
set("PINOCCHIO_INCLUDE_DIRS" "/home/glxrobot/catkin/install/include")
set("pinocchio_DOXYGENDOCDIR" "${PACKAGE_PREFIX_DIR}/share/doc/pinocchio/doxygen-html")
set("PINOCCHIO_DOXYGENDOCDIR" "${PACKAGE_PREFIX_DIR}/share/doc/pinocchio/doxygen-html")
set("pinocchio_DEPENDENCIES" "Eigen3;urdfdom_headers;urdfdom;Boost;hpp-fcl")
set("pinocchio_PKG_CONFIG_DEPENDENCIES" "")

# Find absolute library paths for all _PKG_CONFIG_LIBS as CMake expects full paths, while pkg-config does not.
set(_PACKAGE_CONFIG_LIBRARIES "")
set(_PKG_CONFIG_LIBDIR "/home/glxrobot/catkin/install/lib")
set(_PKG_CONFIG_LIBS_LIST " -lpinocchio -L/usr/lib/x86_64-linux-gnu -lboost_filesystem -lboost_serialization -lboost_system")
if(_PKG_CONFIG_LIBS_LIST)
  string(FIND ${_PKG_CONFIG_LIBS_LIST} ", " _is_comma_space)
  while(_is_comma_space GREATER -1)
    string(REPLACE ", " "," _PKG_CONFIG_LIBS_LIST "${_PKG_CONFIG_LIBS_LIST}")
    string(FIND ${_PKG_CONFIG_LIBS_LIST} ", " _is_comma_space)
  endwhile()
  string(REPLACE " " ";" _PKG_CONFIG_LIBS_LIST "${_PKG_CONFIG_LIBS_LIST}")
  set(LIBDIR_HINTS ${_PKG_CONFIG_LIBDIR})
  foreach(component ${_PKG_CONFIG_LIBS_LIST})
    string(STRIP ${component} component)
    # If the component is a link directory ("-L/full/path"), append to LIBDIR_HINTS.
    string(FIND ${component} "-L" _is_library_dir)
    if(${_is_library_dir} EQUAL 0)
      string(REPLACE "-L" "" lib_path ${component})
      list(APPEND LIBDIR_HINTS "${lib_path}")
      continue()
    endif()
    # If the component is a library name
    string(FIND ${component} "-l" _is_library_name)
    if(${_is_library_name} EQUAL 0)
      string(REPLACE "-l" "" lib ${component})
      find_library(abs_lib_${lib} ${lib} HINTS ${LIBDIR_HINTS})
      if(NOT abs_lib_${lib})
        IF(_LIBDIR_HINTS)
          message(STATUS "${lib} searched on ${_LIBDIR_HINTS} not FOUND.")
        ELSE()
          message(STATUS "${lib} not FOUND.")
        ENDIF()
      else()
        IF(_LIBDIR_HINTS)
          message(STATUS "${lib} searched on ${_LIBDIR_HINTS} FOUND. ${lib} at ${abs_lib_${lib}}")
        ELSE()
          message(STATUS "${lib} FOUND. ${lib} at ${abs_lib_${lib}}")
        ENDIF()
        list(APPEND _PACKAGE_CONFIG_LIBRARIES "${abs_lib_${lib}}")
      endif()
      unset(abs_lib_${lib} CACHE)
      continue()
    endif()
    # If the component contains a collection of additional arguments
    string(FIND ${component} "," _is_collection)
    if(${_is_collection} GREATER -1)
      string(REPLACE "," ";" component_list "${component}")
      list(GET component_list -1 lib_info)
      set(options ${component})
      list(REMOVE_AT options -1)
      string(FIND ${lib_info} "-l" _is_library_name)
      if(${_is_library_name} GREATER -1)
        string(REPLACE "-l" "" lib ${lib_info})
        find_library(abs_lib_${lib} ${lib} HINTS ${LIBDIR_HINTS})
        if(NOT abs_lib_${lib})
          IF(_LIBDIR_HINTS)
            message(STATUS "${lib} searched on ${_LIBDIR_HINTS} not FOUND.")
          ELSE()
            message(STATUS "${lib} not FOUND.")
          ENDIF()
        else()
          IF(_LIBDIR_HINTS)
            message(STATUS "${lib} searched on ${_LIBDIR_HINTS} FOUND. ${lib} at ${abs_lib_${lib}}")
          ELSE()
            message(STATUS "${lib} FOUND. ${lib} at ${abs_lib_${lib}}")
          ENDIF()
          list(APPEND _PACKAGE_CONFIG_LIBRARIES "${abs_lib_${lib}}")
        endif()
        unset(abs_lib_${lib} CACHE)
        continue()
      else() # This is an absolute lib
        list(APPEND _PACKAGE_CONFIG_LIBRARIES "${component}")
      endif()
      continue()
    endif()
    # Else, this is just an absolute lib
    if(EXISTS "${component}")
      list(APPEND _PACKAGE_CONFIG_LIBRARIES "${component}")
    endif()
  endforeach()
endif(_PKG_CONFIG_LIBS_LIST)

set("pinocchio_LIBRARIES" ${_PACKAGE_CONFIG_LIBRARIES})
set("PINOCCHIO_LIBRARIES" ${_PACKAGE_CONFIG_LIBRARIES})

include(CMakeFindDependencyMacro)
if(${CMAKE_VERSION} VERSION_LESS "3.15.0")
  SET(Boost_USE_STATIC_LIBS OFF)
  SET(Boost_USE_MULTITHREADED ON)
  SET(Boost_NO_BOOST_CMAKE ON)
  find_package(Eigen3 REQUIRED)
  find_package(urdfdom_headers)
  find_package(urdfdom)
  find_package(Boost REQUIRED COMPONENTS filesystem serialization system)
  find_package(hpp-fcl 1.4.0 REQUIRED)
else()
  SET(Boost_USE_STATIC_LIBS OFF)
  SET(Boost_USE_MULTITHREADED ON)
  SET(Boost_NO_BOOST_CMAKE ON)
  find_dependency(Eigen3 REQUIRED)
  find_dependency(urdfdom_headers)
  find_dependency(urdfdom)
  find_dependency(Boost REQUIRED COMPONENTS filesystem serialization system)
  find_dependency(hpp-fcl 1.4.0 REQUIRED)
endif()

IF(COMMAND ADD_REQUIRED_DEPENDENCY)
  FOREACH(pkgcfg_dep ${pinocchio_PKG_CONFIG_DEPENDENCIES})
    # Avoid duplicated lookup.
    LIST (FIND $_PKG_CONFIG_REQUIRES "${pkgcfg_dep}" _index)
    IF(${_index} EQUAL -1)
      ADD_REQUIRED_DEPENDENCY(${pkgcfg_dep})
    ENDIF()
  ENDFOREACH()
ENDIF(COMMAND ADD_REQUIRED_DEPENDENCY)

include("${CMAKE_CURRENT_LIST_DIR}/pinocchioTargets.cmake")

foreach(component ${pinocchio_FIND_COMPONENTS})
  set(comp_file "${CMAKE_CURRENT_LIST_DIR}/${component}Config.cmake")
  if(EXISTS ${comp_file})
    include(${comp_file})
  else()
    set(pinocchio_${component}_FOUND FALSE)
  endif()
  if(pinocchio_${component}_FOUND)
    message(STATUS "pinocchio: ${component} found.")
  else()
    message(STATUS "pinocchio: ${component} not found.")
  endif()
endforeach()
check_required_components("pinocchio")


set(PINOCCHIO_USE_URDFDOM "")
set(PINOCCHIO_USE_HPP_FCL "")
