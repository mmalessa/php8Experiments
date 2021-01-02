<?php

class Address
{
    public function __construct(
        public ?string $city = null,
        public ?string $street = null,
        public ?string $number = null
    )
    {}
}

class Man
{
    public function __construct(
        public ?string $name = null,
        public ?int $age = null,
        public ?Address $address = null
    )
    {}
}

$man = new Man(
    'Zbyszko',
    35,
//    new Address('Bogdaniec', 'Grunwaldzka', '1410')
);

printf(
    "%s is %s. Lives in %s, %s, %s\n",
    $man->name,
    $man->age,
    $man?->address?->city,
    $man?->address?->street,
    $man?->address?->number
);
