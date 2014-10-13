#include "bench.hpp"
#include "insertion_sort_n.hpp"

int main(int argc, char * * argv)
{
    bench(argc, argv, [&](auto first, auto count)
    {
        insertion_sort_n(first, count);
    });
}
