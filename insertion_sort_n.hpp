#pragma once

#include <range/v3/algorithm.hpp>

template<typename I, typename V2>
I upper_bound_n(I begin, typename std::iterator_traits<I>::difference_type d, V2 const &val)
{
    while(0 != d)
    {
        auto half = d / 2;
        auto middle = std::next(begin, half);
        if(val < *middle)
            d = half;
        else
        {
            begin = ++middle;
            d -= half + 1;
        }
    }
    return begin;
}

template<typename I>
void insertion_sort_n(I begin, typename std::iterator_traits<I>::difference_type n)
{
    auto m = 0;
    for(auto it = begin; m != n; ++it, ++m)
    {
        auto insertion = upper_bound_n(begin, m, *it);
        ranges::rotate(insertion, it, std::next(it));
    }
}

