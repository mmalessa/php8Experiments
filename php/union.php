<?php

class TestMe
{
    public function write(string|int $input)
    {
        echo $input . PHP_EOL;
    }
}

$xc = new TestMe();
$xc->write('zosia');
$xc->write(12);
$xc->write([1, 2, 3]);