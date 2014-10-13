#include "bench.hpp"
#include "insertion_sort_n.hpp"

int main(int argc, char * * argv)
{
    bench(argc, argv, [&](auto & data, auto count)
    {
        auto it = data.get();
        insertion_sort_n(it, count);
    });
}
