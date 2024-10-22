----------------
--Jakub Zaroda--
----------------

--modul przechowujacy stan algorytmu

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity serpent_round_reg_dec is port(
    in_clk       : in std_logic;                            --wejscie sygnalu zegarowego
    in_ext_wr    : in std_logic;                            --wejscie sygnalu zapisu danych z zewnatrz
    in_int_wr    : in std_logic;                            --wejscie sygnalu zapisu danych z wewnatrz
    in_ext_data    : in std_logic_vector(127 downto 0);     --magistrala wejsciowa danych z zewnatrz
    in_int_data    : in std_logic_vector(127 downto 0);     --magistrala wejsciowa danych z wewnatrz
    in_first_round : in std_logic_vector(127 downto 0);     --magistrala wejsciowa danych z pierwszej rundy
    in_round_number : in std_logic_vector(7 downto 0);      --magistrala wejsciowa numeru rundy
    out_int_data     : out std_logic_vector(127 downto 0)   --magistrala wejsciowa danych
);
end serpent_round_reg_dec;

architecture behaviour of serpent_round_reg_dec is
    signal reg_data : std_logic_vector(127 downto 0)  := (others => '0');       --rejestr przechowujacy stan algorytmu
begin
    process(in_clk)
    begin
        if (rising_edge(in_clk)) then
            if(in_ext_wr='1') then                 --jesli sygnal zapisu danych z zewnatrz w stanie wysokim
                reg_data <= in_ext_data;           --do reg_data zapisane dane z zewnatrz
            end if;

            if(in_int_wr='1') then                  --jesli sygnal zapisu danych z wenatrz w stanie wysokim
                if(in_round_number=x"00") then      --jesli numer rundy==0x00
                    reg_data<=in_first_round;       --do reg_data zapisane dane z magistrali wejsciowej danych z pierwszej rundy
                else                                --w przeciwnym wypadku
                    reg_data <= in_int_data;        --do reg_data zapisane dane z magistrali wejsciowej danych z wewnatrz
                end if;
            end if;
        end if;
    end process;

    out_int_data <= reg_data;                       --na magistrale wyjsciowa wypisywane sa dane z reg_data
end behaviour;