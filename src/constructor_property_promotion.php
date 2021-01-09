<?php
class C
{
    public function __construct(
        private string $name,
        private int $value
    )
    {
    }

    public function getIt()
    {
        printf("%s %d\n", $this->name, $this->value);
    }
}

$c = new C("Zosia", 30);
$c->getIt();

