----------------
--Jakub Zaroda--
----------------

--modul realizujacy skrzynke podstawieniowa s3

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

USE work.key_array_pkg.all;

entity serpent_round_reg is port(
    in_clk       : in std_logic;
    in_ext_wr    : in std_logic;
    in_int_wr    : in std_logic;
    in_ext_data    : in std_logic_vector(127 downto 0);
    in_int_data    : in std_logic_vector(127 downto 0);
    out_int_data     : out std_logic_vector(127 downto 0)
);
end serpent_round_reg;

architecture behaviour of serpent_round_reg is
    signal reg_data : std_logic_vector(127 downto 0)  := (others => '0');
begin
    process(in_clk)
    begin
        if (rising_edge(in_clk)) then
            if(in_ext_wr='1') then                 
                reg_data <= in_ext_data;
            end if;

            if(in_int_wr='1') then                 
                reg_data <= in_int_data;
            end if;
        end if;
    end process;

    out_int_data <= reg_data;
end behaviour;