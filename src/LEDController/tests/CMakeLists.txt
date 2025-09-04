set(APP_TEST "CLEDControllerTest")
set(TEST_SOURCES "CLEDControllerTest.cpp")

add_executable(${APP_TEST} ${TEST_SOURCES})

target_link_libraries(${APP_TEST} gtest::gtest)