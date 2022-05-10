# - Top level CMakeLists.txt for BxInstallers
if(${CMAKE_SOURCE_DIR} STREQUAL ${CMAKE_BINARY_DIR})
  message(STATUS "${PROJECT_NAME} requires an out-of-source build.")
  message(STATUS "Please remove these files from ${CMAKE_BINARY_DIR} first:")
  message(STATUS "  CMakeCache.txt")
  message(STATUS "  CMakeFiles")
  message(STATUS "Once these files are removed, create a separate directory")
  message(STATUS "and run CMake from there, pointing it to:")
  message(STATUS "  ${CMAKE_SOURCE_DIR}")
  message(FATAL_ERROR "in-source build detected")
endif()

cmake_minimum_required(VERSION 3.8 FATAL_ERROR)
project(BxInstallers VERSION 1.0.0)

# Install directories:
include(GNUInstallDirs)

message(STATUS "PROJECT_VERSION=${PROJECT_VERSION}")
message(STATUS "CMAKE_INSTALL_BINDIR=${CMAKE_INSTALL_BINDIR}")
message(STATUS "CMAKE_INSTALL_LIBDIR=${CMAKE_INSTALL_LIBDIR}")

configure_file(${PROJECT_SOURCE_DIR}/bin/bxinstallers-config.in
  ${PROJECT_BINARY_DIR}/bin/bxinstallers-config
  @ONLY)

install(PROGRAMS ${PROJECT_BINARY_DIR}/bin/bxinstallers-config
  TYPE BIN
  )

install(PROGRAMS ${PROJECT_SOURCE_DIR}/bin/bxinstallers-mkskel
  TYPE BIN
  )

install(FILES ${PROJECT_SOURCE_DIR}/lib/libbxiw.bash
  TYPE LIB
  )

install(FILES
  ${PROJECT_SOURCE_DIR}/resources/skel/bxwi_package.locate.in
  ${PROJECT_SOURCE_DIR}/resources/skel/package.bash.in
  ${PROJECT_SOURCE_DIR}/resources/skel/package_installer.in
  DESTINATION ${CMAKE_INSTALL_DATADIR}/bxinstallers/skel
  )

# end