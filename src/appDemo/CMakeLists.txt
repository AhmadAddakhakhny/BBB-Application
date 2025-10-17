set (DEMO_APP_NAME "appDemo")

set (APP_SOURCES "main.cpp" "appDemo.cpp")

add_subdirectory (configured)

add_executable (appDemo ${APP_SOURCES})

target_include_directories (
    appDemo PRIVATE "${CMAKE_BINARY_DIR}/configured_files/include")

if (${CLANG_TIDY_ENABLED})
    add_clang_tidy_to_target (appDemo)
else ()
    include (warnings)
    target_set_warnings (appDemo)

    include (LTO)
    target_enable_lto (appDemo)
endif ()
