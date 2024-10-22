----------------
--Jakub Zaroda--
----------------

--modul realizujacy sterowanie ukladem na podstawie licznika

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity serpent_control is port(
    in_clk       : in std_logic;
    in_reset     : in std_logic;
    in_ext_key_wr    : in std_logic;
    in_ext_data_wr   : in std_logic;
    out_int_kesch_reg_ext_wr     : out std_logic;
    out_int_round_reg_ext_wr     : out std_logic;
    out_int_round_reg_int_wr     : out std_logic;
    out_int_data_out_wr         : out std_logic;
    out_round_number             : out std_logic_vector(7 downto 0);
    out_round_number_one_more : out std_logic_vector(7 downto 0);
    out_busy: out std_logic
);
end serpent_control;

architecture behaviour of serpent_control is
    signal reg_counter : std_logic_vector(7 downto 0)  := (others => '0');
begin
    process(in_clk)
    begin
        if (rising_edge(in_clk)) then       
            if(in_reset='1') then                                                   --jezeli sygnal in_reset jest w stanie wysokim licznik jest zerowany
                reg_counter <=(others => '0');
            else                                                                    --jesli sygnal resetu nie jest w stanie wysokim
                if(in_ext_data_wr='1' or reg_counter /= x"00") then                 --jesli licznik jest rozny od zera lub sygnal zapisu danych z zewnatrz jest w stanie wysokim
                    if(reg_counter = x"20") then                                    --to licznik jest zerowany gdzy osiagnie wartosc 0x20
                        reg_counter <=(others => '0');
                    else                                                            
                        reg_counter <= std_logic_vector((unsigned(reg_counter))+1); --lub licznik jest zwiekszany o 1
                    end if;
                end if;
            end if;
        end if;
    end process;

    out_int_kesch_reg_ext_wr <= in_ext_key_wr when (reg_counter=x"00") else '0';        --sygnalu zapisu do rejestru klucza danych z zewnatrz jest w stanie wysokim gdy in_ext_key_wr='1' i licznik jest wyzerowany

    out_int_round_reg_ext_wr <= in_ext_data_wr when (reg_counter=x"00") else '0';       --sygnalu zapisu do rejestru rundy danych z zewnatrz jest w stanie wysokim gdy in_ext_data_wr='1' i licznik jest wyzerowany

    out_int_round_reg_int_wr <= '0' when (reg_counter=x"00") else '1';      --sygnalu zapisu do rejestru rundy danych z wewnatrz jest w stanie wysokim gdy uklad pracuje (licznik rozny od 0)

    out_int_data_out_wr <= '1' when (reg_counter=x"20") else '0';           --sygnalu zapisu do rejestru wyjsciowego jest w stanie wysokim w ostatnim takcie pracy licznika

    out_round_number <= x"00" when (reg_counter=x"00") else (std_logic_vector(unsigned(reg_counter)-1)); --na magistrale wyjsciowa przechowujaca numer rundy wypisywany jest stan licznika-1

    out_round_number_one_more <= x"00" when (reg_counter=x"00") else reg_counter; --na magistrale wyjsciowa przechowujaca numer rundy(+1) wypisywany jest stan licznika

    out_busy <= '0' when (reg_counter=x"00") else '1';      --sygnal pracy ukladu jest w stanie wysokim gdy licznik jest rozny od 0

end behaviour;