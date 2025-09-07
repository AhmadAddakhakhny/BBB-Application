set (LEDCONTROLLER_APP_NAME "LEDController")

set (APP_SOURCES "main.cpp" "LEDController.cpp")

add_subdirectory (configured)

add_executable (LEDController ${APP_SOURCES})

target_include_directories (
    LEDController PRIVATE "${CMAKE_BINARY_DIR}/configured_files/include")

if (${CLANG_TIDY_ENABLED})
    add_clang_tidy_to_target (LEDController)
else ()
    include (warnings)
    target_set_warnings (LEDController)

    include (LTO)
    target_enable_lto (LEDController)
endif ()
