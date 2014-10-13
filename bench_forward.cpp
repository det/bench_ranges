#include "bench.hpp"
#include "forward_iterator.hpp"
#include "insertion_sort.hpp"

int main(int argc, char **argv)
{
    bench(argc, argv, [&](auto & data, auto count)
    {
        auto it = make_forward_iterator(data.get());
        insertion_sort(ranges::view::counted(it, count));
    });
}
