----------------
--Jakub Zaroda--
----------------

--modul realizujacy przeksztalcenie liniowe na podstawie dokumentacji

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity serpent_linear_transform is port(
    in_data      : in std_logic_vector (127 downto 0);      --magistrala danych wejsciowych
    out_data     : out std_logic_vector (127 downto 0)      --magistrala danych wyjsciowych
);
end serpent_linear_transform;

architecture behaviour of serpent_linear_transform is
    --rejestry pomocnicze
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

    x_0_1 <= x_0(18 downto 0) & x_0(31 downto 19);                   --rotacja w lewo o 13b
    x_2_1 <= x_2(28 downto 0) & x_2(31 downto 29);                   --rotacja w lewo o 3b
    x_1_1 <= x_1 xor x_0_1 xor x_2_1;                                --xor odpowiednich rejestrow
    x_3_1 <= x_3 xor x_2_1 xor (x_0_1(28 downto 0) & "000");         --xor odpowiednich rejestrow oraz przesunietego w lewo o 3b rejestru x_0

    x_1_2 <= x_1_1(30 downto 0) & x_1_1(31);                         --rotacja w lewo o 1b
    x_3_2 <= x_3_1(24 downto 0) & x_3_1(31 downto 25);               --rotacja w lewo o 7b
    x_0_2 <= x_0_1 xor x_1_2 xor x_3_2;                              --xor odpowiednich rejestrow
    x_2_2 <= x_2_1 xor x_3_2 xor (x_1_2(24 downto 0) & "0000000");   --xor odpowiednich rejestrow oraz przesunietego w lewo o 7b rejestru x_1

    x_0_3 <= x_0_2(26 downto 0) & x_0_2(31 downto 27);               --rotacja w lewo o 5b
    x_2_3 <= x_2_2(9 downto 0) & x_2_2(31 downto 10);                --rotacja w lewo o 22b

    out_data (127 downto 96) <= x_0_3;
    out_data (95 downto 64) <= x_1_2;
    out_data (63 downto 32) <= x_2_3;
    out_data (31 downto 0) <= x_3_2;
end behaviour;