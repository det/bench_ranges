#pragma once

#include <algorithm>
#include <chrono>
#include <memory>
#include <numeric>
#include <iostream>
#include <random>
#include <stdexcept>
#include <utility>

template<typename Functor, typename ... Args>
void bench(int argc, char **argv, Functor functor, Args && ... args)
{
    if (argc != 2) throw std::runtime_error{"Requires 1 parameter"};
    int count = atoi(argv[1]);

    std::unique_ptr<int[]> data(new int[count]);
    auto first = data.get();
    auto last = first + count;

    std::iota(first, last, 0);
    std::default_random_engine engine;
    std::shuffle(first, last, engine);

    auto start = std::chrono::high_resolution_clock::now();
    functor(first, count, std::forward<Args>(args) ...);
    auto stop = std::chrono::high_resolution_clock::now();

    if (!std::is_sorted(first, last)) throw std::runtime_error{"Insertion sort failed"};

    auto ns = std::chrono::duration_cast<std::chrono::nanoseconds>(stop - start);
    std::cout << ns.count() / 1000000.0 << "ms\n";
}
