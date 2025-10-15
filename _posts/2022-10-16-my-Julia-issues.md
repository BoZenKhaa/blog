## Generators that will be type stable?

E.g., expression `argmax(q, children(snode))` seems to dynamically dispatch when children returns a generator.

There is a passive aggressive discussion on the topic here: https://discourse.julialang.org/t/can-eltype-deduce-the-element-type-of-a-generator/6429