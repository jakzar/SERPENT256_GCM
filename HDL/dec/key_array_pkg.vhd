LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

PACKAGE key_array_pkg IS
    type key_array is array (0 to 32) of std_logic_vector (127 downto 0);
END; 