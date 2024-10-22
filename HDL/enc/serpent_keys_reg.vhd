----------------
--Jakub Zaroda--
----------------

--modul serpent_keys_reg przechowuje klucz glowny algorytmu

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity serpent_keys_reg is port(
    in_clk       : in std_logic;                                --wejscie sygnalu zegarowego
    in_ext_wr    : in std_logic;                                --wejscie sygnalu zapisu klucza glownego z zewnatrz
    in_master_key    : in std_logic_vector(255 downto 0);       --magistrala wejsciowa z kluczem glownym 
    out_master_key     : out std_logic_vector(255 downto 0)     --magistrala wyjsciowa z kluczem glownym 
);
end serpent_keys_reg;

architecture behaviour of serpent_keys_reg is
    signal reg_master_key : std_logic_vector(255 downto 0)  := (others => '0');     --rejestr przechowuajcy klucz glowny
begin
    process(in_clk)
    begin
        if (rising_edge(in_clk)) then
            if(in_ext_wr='1') then                 
                reg_master_key <= in_master_key;
            end if;
        end if;
    end process;

    out_master_key <= reg_master_key;
end behaviour;