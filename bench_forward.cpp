#include "bench.hpp"
#include "forward_iterator.hpp"
#include "insertion_sort.hpp"

int main(int argc, char **argv)
{
    bench(argc, argv, [&](auto first, auto count)
    {
        insertion_sort(ranges::view::counted(make_forward_iterator(first), count));
    });
}
