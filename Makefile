FLAGS=-Wall -Wpedantic -std=c++14 -Isubmodule/range-v3/include/
CLANG_FLAGS=${FLAGS} -stdlib=libc++ -lc++abi
GCC_FLAGS=${FLAGS}

HEADERS=bench.hpp
FORWARD_HEADERS=${HEADERS} forward_iterator.hpp insertion_sort.hpp
FORWARD_N_HEADERS=${HEADERS} forward_iterator.hpp insertion_sort_n.hpp
RANDOM_HEADERS=${HEADERS} insertion_sort.hpp
RANDOM_N_HEADERS=${HEADERS} insertion_sort_n.hpp

COUNT=50000
REPS=5

all: clang gcc

bench_forward_clang_opt2: ${FORWARD_HEADERS} bench_forward.cpp
	clang++ ${CLANG_FLAGS} -O2 -o bench_forward_clang_opt2 bench_forward.cpp

bench_forward_clang_opt3: ${FORWARD_HEADERS} bench_forward.cpp
	clang++ ${CLANG_FLAGS} -O3 -o bench_forward_clang_opt3 bench_forward.cpp

bench_forward_n_clang_opt2: ${FORWARD_N_HEADERS} bench_forward_n.cpp
	clang++ ${CLANG_FLAGS} -O2 -o bench_forward_n_clang_opt2 bench_forward_n.cpp

bench_forward_n_clang_opt3: ${FORWARD_N_HEADERS} bench_forward_n.cpp
	clang++ ${CLANG_FLAGS} -O3 -o bench_forward_n_clang_opt3 bench_forward_n.cpp

bench_random_clang_opt2: ${RANDOM_HEADERS} bench_random.cpp
	clang++ ${CLANG_FLAGS} -O2 -o bench_random_clang_opt2 bench_random.cpp

bench_random_clang_opt3: ${RANDOM_HEADERS} bench_random.cpp
	clang++ ${CLANG_FLAGS} -O3 -o bench_random_clang_opt3 bench_random.cpp

bench_random_n_clang_opt2: ${RANDOM_N_HEADERS} bench_random_n.cpp
	clang++ ${CLANG_FLAGS} -O2 -o bench_random_n_clang_opt2 bench_random_n.cpp

bench_random_n_clang_opt3: ${RANDOM_N_HEADERS} bench_random_n.cpp
	clang++ ${CLANG_FLAGS} -O3 -o bench_random_n_clang_opt3 bench_random_n.cpp	


clang_forward: bench_forward_clang_opt2 bench_forward_clang_opt3
clang_forward_n: bench_forward_n_clang_opt2 bench_forward_n_clang_opt3
clang_random: bench_random_clang_opt2 bench_random_clang_opt3
clang_random_n: bench_random_n_clang_opt2 bench_random_n_clang_opt3
clang: clang_forward clang_forward_n clang_random clang_random_n

bench_forward_gcc_opt2: ${FORWARD_HEADERS} bench_forward.cpp
	g++ ${GCC_FLAGS} -O2 -o bench_forward_gcc_opt2 bench_forward.cpp

bench_forward_gcc_opt3: ${FORWARD_HEADERS} bench_forward.cpp
	g++ ${GCC_FLAGS} -O3 -o bench_forward_gcc_opt3 bench_forward.cpp

bench_forward_n_gcc_opt2: ${FORWARD_N_HEADERS} bench_forward_n.cpp
	g++ ${GCC_FLAGS} -O2 -o bench_forward_n_gcc_opt2 bench_forward_n.cpp

bench_forward_n_gcc_opt3: ${FORWARD_N_HEADERS} bench_forward_n.cpp
	g++ ${GCC_FLAGS} -O3 -o bench_forward_n_gcc_opt3 bench_forward_n.cpp

bench_random_gcc_opt2: ${RANDOM_HEADERS} bench_random.cpp
	g++ ${GCC_FLAGS} -O2 -o bench_random_gcc_opt2 bench_random.cpp

bench_random_gcc_opt3: ${RANDOM_HEADERS} bench_random.cpp
	g++ ${GCC_FLAGS} -O3 -o bench_random_gcc_opt3 bench_random.cpp

bench_random_n_gcc_opt2: ${RANDOM_N_HEADERS} bench_random_n.cpp
	g++ ${GCC_FLAGS} -O2 -o bench_random_n_gcc_opt2 bench_random_n.cpp

bench_random_n_gcc_opt3: ${RANDOM_N_HEADERS} bench_random_n.cpp
	g++ ${GCC_FLAGS} -O3 -o bench_random_n_gcc_opt3 bench_random_n.cpp	

gcc_forward: bench_forward_gcc_opt2 bench_forward_gcc_opt3
gcc_forward_n: bench_forward_n_gcc_opt2 bench_forward_n_gcc_opt3
gcc_random: bench_random_gcc_opt2 bench_random_gcc_opt3
gcc_random_n: bench_random_n_gcc_opt2 bench_random_n_gcc_opt3
gcc: gcc_forward gcc_forward_n gcc_random gcc_random_n


define bench
	@echo -n "$1: "
	@for i in {0..${REPS}}; do $2 ${COUNT}; done | sort -n | head -1
endef

bench_clang: clang
	$(call bench,clang -O2 forward,./bench_forward_clang_opt2)
	$(call bench,clang -O2 forward_n,./bench_forward_n_clang_opt2)
	$(call bench,clang -O3 forward,./bench_forward_clang_opt3)
	$(call bench,clang -O3 forward_n,./bench_forward_n_clang_opt3)
	$(call bench,clang -O2 random,./bench_random_clang_opt2)
	$(call bench,clang -O2 random_n,./bench_random_n_clang_opt2)
	$(call bench,clang -O3 random,./bench_random_clang_opt3)
	$(call bench,clang -O3 random_n,./bench_random_n_clang_opt3)

bench_gcc: gcc
	$(call bench,gcc -O2 forward,./bench_forward_gcc_opt2)
	$(call bench,gcc -O2 forward_n,./bench_forward_n_gcc_opt2)
	$(call bench,gcc -O3 forward,./bench_forward_gcc_opt3)
	$(call bench,gcc -O3 forward_n,./bench_forward_n_gcc_opt3)
	$(call bench,gcc -O2 random,./bench_random_gcc_opt2)
	$(call bench,gcc -O2 random_n,./bench_random_n_gcc_opt2)
	$(call bench,gcc -O3 random,./bench_random_gcc_opt3)
	$(call bench,gcc -O3 random_n,./bench_random_n_gcc_opt3)

bench: clang gcc bench_clang bench_gcc

clean_clang:
	rm -f bench_forward_clang_opt2
	rm -f bench_forward_clang_opt3
	rm -f bench_forward_n_clang_opt2
	rm -f bench_forward_n_clang_opt3
	rm -f bench_random_clang_opt2
	rm -f bench_random_clang_opt3
	rm -f bench_random_n_clang_opt2
	rm -f bench_random_n_clang_opt3

clean_gcc:
	rm -f bench_forward_gcc_opt2
	rm -f bench_forward_gcc_opt3
	rm -f bench_forward_n_gcc_opt2
	rm -f bench_forward_n_gcc_opt3
	rm -f bench_random_gcc_opt2
	rm -f bench_random_gcc_opt3
	rm -f bench_random_n_gcc_opt2
	rm -f bench_random_n_gcc_opt3

clean: clean_gcc clean_clang

.PHONY: bench_clang bench_gcc bench clean_clang clean_gcc clean

