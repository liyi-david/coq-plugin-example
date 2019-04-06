# coq-plugin-example
a very simple coq plugin, for introduction purpose

# steps

1. an empty plugin (and does nothing, of course) commit 563af24ac0e621fbe90d4e1762b58ade6a5d8673
2. extend the plugin with and idle vernac command

    ```coq
    Coq < Require Import P1.plugin.
    [Loading ML file P1.cmxs ... done]

    Coq < Idle.
    nothing happens.

    Coq <
    ```
