----------------
--Jakub Zaroda--
----------------

--modul realizujacy ostatnia runde szyfrowania

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity serpent_last_round_fun is port(
    in_data      : in std_logic_vector (127 downto 0);      --magistrala wejsciowa danych
    in_key_0      : in std_logic_vector (127 downto 0);     --magistrala wejsciowa klucza
    in_key_1      : in std_logic_vector (127 downto 0);     --magistrala wejsciowa drugiego klucza
    out_data     : out std_logic_vector (127 downto 0)      --magistrala wyjsciowa danych
);
end serpent_last_round_fun;

architecture behaviour of serpent_last_round_fun is
    --rejestry pomocnicze
    signal temp_0 : std_logic_vector (127 downto 0);
    signal out_s7 : std_logic_vector (127 downto 0);
begin
    --dodanie pierwszego klucza
    temp_0 <= in_data xor in_key_0;

    --przepuszczenie przez Sboxa
    s7: entity work.serpent_sub_key_7_fun port map(temp_0, out_s7);

    --dodanie drugiego klucza rundowego
    out_data <= out_s7 xor in_key_1;
end behaviour;