set(LEDCONTROLLER_APP_NAME "LEDController")

set(APP_SOURCES 
    "main.cpp"
    "LEDController.cpp")
    
add_subdirectory(configured)

add_executable(LEDController ${APP_SOURCES})
    
target_include_directories(LEDController PRIVATE
    "${CMAKE_BINARY_DIR}/configured_files/include")

include(warnings)
target_set_warnings(LEDController)

include(LTO)
target_enable_lto(LEDController)