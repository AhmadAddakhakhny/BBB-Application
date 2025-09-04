set(APP_TEST "CLEDControllerTest")
set(TEST_SOURCES "CLEDControllerTest.cpp")

add_executable(${APP_TEST} ${TEST_SOURCES})
target_link_libraries(${APP_TEST} PRIVATE GTest::gtest_main)
include(GoogleTest)

enable_testing()
gtest_discover_tests(${APP_TEST}
  DISCOVERY_MODE PRE_TEST
)