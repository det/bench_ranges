#pragma once

#include <range/v3/algorithm.hpp>

template<typename I, typename S>
void insertion_sort(I begin, S end)
{
    for(auto it = begin; it != end; ++it)
    {
        auto insertion = ranges::upper_bound(begin, it, *it);
        ranges::rotate(insertion, it, std::next(it));
    }
}

template<typename Rng>
void insertion_sort(Rng && rng)
{
    insertion_sort(std::begin(rng), std::end(rng));
}

