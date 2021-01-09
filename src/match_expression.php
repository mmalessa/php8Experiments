<?php

$myValues = [0, 1, 2];

foreach ($myValues as $myValue) {
    printf("%d -> %s\n", $myValue, getMessage($myValue));
}

function getMessage(int $testedValue): string
{
    return match ($testedValue) {
        0 => "It's zero",
        1 => "It's one",
        default => "I don't know what it is"
    };
}
