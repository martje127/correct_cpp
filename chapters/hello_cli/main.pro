# Files
SOURCES += *.cpp
HEADERS += *.h

# g++-5
#CONFIG += c++11 and gold linker
#QMAKE_CXXFLAGS += -std=c++11
#QMAKE_LFLAGS += -fuse-ld=gold
# g++-6: use C++14 and gold linker
#CONFIG += c++14
#QMAKE_CXXFLAGS += -std=c++14
#QMAKE_LFLAGS += -fuse-ld=gold
# g++-7: use C++17 and gold linker
CONFIG += c++17
QMAKE_CXXFLAGS += -std=c++17
QMAKE_LFLAGS += -fuse-ld=gold

# High warnings levels
QMAKE_CXXFLAGS += -Wall -Wextra -Wshadow -Wnon-virtual-dtor -pedantic -Weffc++ -Werror

# Allow debug and release mode
CONFIG += debug_and_release

# In debug mode, turn on gcov, memcache and UBSAN
CONFIG(debug, debug|release) {

  # gcov
  QMAKE_CXXFLAGS += -fprofile-arcs -ftest-coverage
  LIBS += -lgcov

  # helgrind, for helgrind and memcheck
  QMAKE_LFLAGS += -pthread -Wl,--no-as-needed
  
  # UBSAN
  QMAKE_CXXFLAGS += -fsanitize=undefined
  QMAKE_LFLAGS += -fsanitize=undefined
  LIBS += -lubsan
}

# In release mode, turn on profiling
CONFIG(release, debug|release) {

  DEFINES += NDEBUG

  # gprof
  QMAKE_CXXFLAGS += -pg
  QMAKE_LFLAGS += -pg
}
