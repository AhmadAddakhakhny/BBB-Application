# =======================================
# Component: appDemo
# =======================================

set(DEMO_APP_NAME "appDemo")
set(APP_SOURCES "main.cpp" "appDemo.cpp")

add_subdirectory(configured)

add_executable(${DEMO_APP_NAME} ${APP_SOURCES})

target_include_directories(
    ${DEMO_APP_NAME} PRIVATE
    "${CMAKE_BINARY_DIR}/configured_files/include"
)

# --- Compiler warnings, clang-tidy, LTO ---
if(CLANG_TIDY_ENABLED)
    add_clang_tidy_to_target(${DEMO_APP_NAME})
else()
    include(warnings)
    target_set_warnings(${DEMO_APP_NAME})

    include(LTO)
    target_enable_lto(${DEMO_APP_NAME})
endif()

# --- Install step ---
# This installs the binary and its unit file (if any)
install(TARGETS ${DEMO_APP_NAME}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

# Optional: If this app has a systemd service, install it too
set(SYSTEMD_UNIT "${CMAKE_CURRENT_SOURCE_DIR}/appDemo.service")
if(EXISTS "${SYSTEMD_UNIT}")
    install(FILES ${SYSTEMD_UNIT}
        DESTINATION ${CMAKE_INSTALL_SYSTEMD_UNITDIR}
    )
endif()
