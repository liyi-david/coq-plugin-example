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

3. extend the plugin to render tree structure of a term

    ```
    Coq < Require Import P1.plugin.
    [Loading ML file printr.cmxs ... done]
    [Loading ML file P1.cmxs ... done]

    Coq < Definition a := 1.
    a is defined

    Coq < Printr a.
    <const : a>

    Coq < Printr (a + 1).
    <app : (a + 1)>
      <const : Nat.add>
      <const : a>
      <app : 1>
        <construct : S>
        <construct : 0>
    ```
