#include "bench.hpp"
#include "insertion_sort.hpp"

#include <range/v3/view.hpp>

int main(int argc, char **argv)
{
    bench(argc, argv, [&](auto first, auto count)
    {
        insertion_sort(ranges::view::counted(first, count));
    });
}
