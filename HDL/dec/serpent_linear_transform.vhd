----------------
--Jakub Zaroda--
----------------

--modul realizujacy skrzynke podstawieniowa s7

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity serpent_linear_transform is port(
    in_data      : in std_logic_vector (127 downto 0);
    out_data     : out std_logic_vector (127 downto 0)
);
end serpent_linear_transform;

architecture behaviour of serpent_linear_transform is
    signal x_0 : std_logic_vector (31 downto 0);
    signal x_1 : std_logic_vector (31 downto 0);
    signal x_2 : std_logic_vector (31 downto 0);
    signal x_3 : std_logic_vector (31 downto 0);

    signal x_0_1 : std_logic_vector (31 downto 0);
    signal x_2_1 : std_logic_vector (31 downto 0);
    signal x_1_1 : std_logic_vector (31 downto 0);
    signal x_3_1 : std_logic_vector (31 downto 0);

    signal x_1_2 : std_logic_vector (31 downto 0);
    signal x_3_2 : std_logic_vector (31 downto 0);
    signal x_0_2 : std_logic_vector (31 downto 0);
    signal x_2_2 : std_logic_vector (31 downto 0);

    signal x_0_3 : std_logic_vector (31 downto 0);
    signal x_2_3 : std_logic_vector (31 downto 0);
begin
    x_0 <= in_data (127 downto 96);
    x_1 <= in_data (95 downto 64);
    x_2 <= in_data (63 downto 32);
    x_3 <= in_data (31 downto 0);

    x_0_1 <= x_0(18 downto 0) & x_0(31 downto 19);
    x_2_1 <= x_2(28 downto 0) & x_2(31 downto 29);
    x_1_1 <= x_1 xor x_0_1 xor x_2_1;
    x_3_1 <= x_3 xor x_2_1 xor (x_0_1(28 downto 0) & "000");

    x_1_2 <= x_1_1(30 downto 0) & x_1_1(31);
    x_3_2 <= x_3_1(24 downto 0) & x_3_1(31 downto 25);
    x_0_2 <= x_0_1 xor x_1_2 xor x_3_2;
    x_2_2 <= x_2_1 xor x_3_2 xor (x_1_2(24 downto 0) & "0000000");

    x_0_3 <= x_0_2(26 downto 0) & x_0_2(31 downto 27);
    x_2_3 <= x_2_2(9 downto 0) & x_2_2(31 downto 10);

    out_data (127 downto 96) <= x_0_3;
    out_data (95 downto 64) <= x_1_2;
    out_data (63 downto 32) <= x_2_3;
    out_data (31 downto 0) <= x_3_2;
end behaviour;