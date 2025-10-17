# =======================================
# Unit Tests for appDemo
# =======================================

set(APP_TEST "appDemoTests")
set(TEST_SOURCES "DemoTest.cpp")

add_executable(${APP_TEST} ${TEST_SOURCES})
target_link_libraries(${APP_TEST} PRIVATE GTest::gtest_main)

include(GoogleTest)
enable_testing()
gtest_discover_tests(${APP_TEST} DISCOVERY_MODE PRE_TEST)

# --- Coverage Configuration ---
set(COVERAGE_MAIN "coverage")
set(COVERAGE_EXCLUDES
    "${PROJECT_SOURCE_DIR}/builds/*"
    "${PROJECT_SOURCE_DIR}/cmake/*"
    "${PROJECT_SOURCE_DIR}/docs/*"
    "${PROJECT_SOURCE_DIR}/scripts/*"
    "${PROJECT_SOURCE_DIR}/sdl/*"
    "${PROJECT_SOURCE_DIR}/tools/*"
    "/usr/include/*"
)
set(COVERAGE_DEPENDENCIES ${APP_TEST})

setup_target_for_coverage_gcovr_html(
    NAME ${COVERAGE_MAIN}
    EXECUTABLE ctest
    DEPENDENCIES ${COVERAGE_DEPENDENCIES}
    BASE_DIRECTORY ${CMAKE_SOURCE_DIR}
)