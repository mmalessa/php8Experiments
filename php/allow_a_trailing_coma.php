<?php

function sumMe(
    int $first,
    int $second,
): int
{
    return $first + $second;
}

printf("%d + %d = %d\n", 10, 5, sumMe(10, 5));
