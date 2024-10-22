----------------
--Jakub Zaroda--
----------------

--modul realizujacy funkcje pelnej rundy

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity serpent_change_to_cols is port(
    in_data_0  :   in std_logic_vector (31 downto 0);
    in_data_1  :   in std_logic_vector (31 downto 0);
    in_data_2  :   in std_logic_vector (31 downto 0);
    in_data_3  :   in std_logic_vector (31 downto 0);
    out_data :   out std_logic_vector (127 downto 0)
);
end entity serpent_change_to_cols;

architecture behaviour of serpent_change_to_cols is
begin
    out_data <= in_data_3(31) & in_data_2(31) & in_data_1(31) & in_data_0(31) & in_data_3(30) & in_data_2(30) & in_data_1(30) & in_data_0(30)  & in_data_3(29) & in_data_2(29) & in_data_1(29) & in_data_0(29)  & in_data_3(28) & in_data_2(28) & in_data_1(28) & in_data_0(28)  & in_data_3(27) & in_data_2(27) & in_data_1(27) & in_data_0(27)  & in_data_3(26) & in_data_2(26) & in_data_1(26) & in_data_0(26)  & in_data_3(25) & in_data_2(25) & in_data_1(25) & in_data_0(25)  & in_data_3(24) & in_data_2(24) & in_data_1(24) & in_data_0(24)  & in_data_3(23) & in_data_2(23) & in_data_1(23) & in_data_0(23)  & in_data_3(22) & in_data_2(22) & in_data_1(22) & in_data_0(22)  & in_data_3(21) & in_data_2(21) & in_data_1(21) & in_data_0(21)  & in_data_3(20) & in_data_2(20) & in_data_1(20) & in_data_0(20)  & in_data_3(19) & in_data_2(19) & in_data_1(19) & in_data_0(19)  & in_data_3(18) & in_data_2(18) & in_data_1(18) & in_data_0(18)  & in_data_3(17) & in_data_2(17) & in_data_1(17) & in_data_0(17)  & in_data_3(16) & in_data_2(16) & in_data_1(16) & in_data_0(16)  & in_data_3(15) & in_data_2(15) & in_data_1(15) & in_data_0(15)  & in_data_3(14) & in_data_2(14) & in_data_1(14) & in_data_0(14)  & in_data_3(13) & in_data_2(13) & in_data_1(13) & in_data_0(13)  & in_data_3(12) & in_data_2(12) & in_data_1(12) & in_data_0(12)  & in_data_3(11) & in_data_2(11) & in_data_1(11) & in_data_0(11)  & in_data_3(10) & in_data_2(10) & in_data_1(10) & in_data_0(10)  & in_data_3(9) & in_data_2(9) & in_data_1(9) & in_data_0(9)  & in_data_3(8) & in_data_2(8) & in_data_1(8) & in_data_0(8)  & in_data_3(7) & in_data_2(7) & in_data_1(7) & in_data_0(7)  & in_data_3(6) & in_data_2(6) & in_data_1(6) & in_data_0(6)  & in_data_3(5) & in_data_2(5) & in_data_1(5) & in_data_0(5)  & in_data_3(4) & in_data_2(4) & in_data_1(4) & in_data_0(4)  & in_data_3(3) & in_data_2(3) & in_data_1(3) & in_data_0(3)  & in_data_3(2) & in_data_2(2) & in_data_1(2) & in_data_0(2)  & in_data_3(1) & in_data_2(1) & in_data_1(1) & in_data_0(1)  & in_data_3(0) & in_data_2(0) & in_data_1(0) & in_data_0(0); 


end behaviour;