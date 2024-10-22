----------------
--Jakub Zaroda--
----------------

--modul realizujacy skrzynke podstawieniowa s0

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity serpent_sbox7_inv is port(
    in_data      : in std_logic_vector (3 downto 0);
    out_data     : out std_logic_vector (3 downto 0)
);
end serpent_sbox7_inv;

architecture behaviour of serpent_sbox7_inv is
begin
	p_sbox : process (in_data)
	begin
    case (in_data) is
        when x"0" => out_data <= x"3";
        when x"1" => out_data <= x"0";
        when x"2" => out_data <= x"6";
        when x"3" => out_data <= x"d";
        when x"4" => out_data <= x"9";
        when x"5" => out_data <= x"e";
        when x"6" => out_data <= x"f";
        when x"7" => out_data <= x"8";
        when x"8" => out_data <= x"5";
        when x"9" => out_data <= x"c";
        when x"a" => out_data <= x"b";
        when x"b" => out_data <= x"7";
        when x"c" => out_data <= x"a";
        when x"d" => out_data <= x"1";
        when x"e" => out_data <= x"4";
        when x"f" => out_data <= x"2";

        when others => null;
    end case;
	 end process p_sbox;
end behaviour;