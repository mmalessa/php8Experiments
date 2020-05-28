<?php
class C
{
    public function __construct(
        string $name,
        int $value
    )
    {
    }
}

$c = new C("Zosia", 30);

var_dump($c::class);
echo PHP_EOL;

