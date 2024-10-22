LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

PACKAGE w_array_pkg IS
    type w_array is array (0 to 7) of std_logic_vector (31 downto 0);
END; 