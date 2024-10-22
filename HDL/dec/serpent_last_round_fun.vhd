----------------
--Jakub Zaroda--
----------------

--modul realizujacy skrzynke podstawieniowa s7

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity serpent_last_round_fun is port(
    in_clk       : in std_logic;
    in_data      : in std_logic_vector (127 downto 0);
    in_key_0      : in std_logic_vector (127 downto 0);
    in_key_1      : in std_logic_vector (127 downto 0);
    out_data     : out std_logic_vector (127 downto 0)
);
end serpent_last_round_fun;

architecture behaviour of serpent_last_round_fun is
    signal temp_0 : std_logic_vector (127 downto 0);
    signal temp_1 : std_logic_vector (127 downto 0);
    signal temp_2 : std_logic_vector (127 downto 0);

    signal out_s7 : std_logic_vector (127 downto 0);
begin
    temp_0 <= in_data xor in_key_0;

    s7: entity work.serpent_sub_key_7_fun port map(temp_0, out_s7);

    out_data <= out_s7 xor in_key_1;


end behaviour;