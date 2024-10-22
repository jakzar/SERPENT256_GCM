----------------
--Jakub Zaroda--
----------------

--modul przechowuajcy przetworzony stan algorytmu  

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity serpent_data_out_reg is port(
    in_clk       : in std_logic;                    --wejscie sygnalu zegarowego
    in_reset : in std_logic;
    in_wr    : in std_logic;                        --wejscie sygnalu zapisu do rejestru
    in_data  : in std_logic_vector(127 downto 0);   --magistrala wejsciowa danych
    out_data : out std_logic_vector(127 downto 0)   --magistrala wyjsciowa danych
);
end serpent_data_out_reg;

architecture behaviour of serpent_data_out_reg is
    signal reg_data : std_logic_vector(127 downto 0)  := (others => '0');   --rejestr przechowuajcy przetworzone dane

begin
    process(in_clk)
    begin
        if (rising_edge(in_clk)) then
            if(in_reset='1') then
                reg_data <= (others => '0');
            else
                if(in_wr='1') then                 --jesli sygnal zapisu do rejestru jest w stanie wysokim
                    reg_data <= in_data;           --do rejestru zapisywane sa dane z magistrali wejsciowej
                end if;
            end if;
        end if;
    end process;

    out_data <= reg_data;                       --na magistrale wyjsciowa wypisywana jest zawartosc rejestru reg_data
end behaviour;