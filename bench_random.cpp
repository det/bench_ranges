#include "bench.hpp"
#include "insertion_sort.hpp"

int main(int argc, char * * argv)
{
    bench(argc, argv, [&](auto & data, auto count)
    {
        auto it = data.get();
        insertion_sort(ranges::view::counted(it, count));
    });
}
