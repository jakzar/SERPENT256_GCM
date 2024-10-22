----------------
--Jakub Zaroda--
----------------

--modul wyznaczajacy kolejne klucze rundowe
--modul wyznacza kolejne klucze rundowe, liczac od konca, na podstawie podanych dwoch ostatnich kluczy rundowych wyznaczonych podczas szyfrowania

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

USE work.w_array_pkg.all;

entity serpent_keys_dec is port(
    in_clk       : in std_logic;                                --wejscie sygnalu zegarowego
    in_data      : in  std_logic_vector (255 downto 0);         --magistrala wejsciowa klucza glownego
    in_round_number : in std_logic_vector(7 downto 0);          --magistrala wejsciowa numeru rundy
    out_key      : out std_logic_vector (127 downto 0);         --magistrala wyjsciowa klucza rundowego
    out_key_2      : out std_logic_vector (127 downto 0)        --magistrala wyjsciowa drugiego klucza rundowego (uzywana podczas pierwszej rundy)
);
end serpent_keys_dec;

architecture behaviour of serpent_keys_dec is

    signal w : w_array;                                         --8 elementowa tablica przechowujaca slowa w potrzebne do wyznaczenia kluczy rundwywch

    --rejestry pomocnicze
    signal tmp_4 : std_logic_vector (31 downto 0);              
    signal tmp_3 : std_logic_vector (31 downto 0);
    signal tmp_2 : std_logic_vector (31 downto 0);
    signal tmp_1 : std_logic_vector (31 downto 0);


    signal tmp_con : std_logic_vector (127 downto 0);

    signal out_s0 : std_logic_vector (127 downto 0);
    signal out_s1 : std_logic_vector (127 downto 0);
    signal out_s2 : std_logic_vector (127 downto 0);
    signal out_s3 : std_logic_vector (127 downto 0);
    signal out_s4 : std_logic_vector (127 downto 0);
    signal out_s5 : std_logic_vector (127 downto 0);
    signal out_s6 : std_logic_vector (127 downto 0);
    signal out_s7 : std_logic_vector (127 downto 0);

    signal in_key_0 : std_logic_vector (127 downto 0);
    signal in_key_1 : std_logic_vector (127 downto 0);
    signal w_from_key_1 : std_logic_vector (127 downto 0);
    signal w_from_key_0 : std_logic_vector (127 downto 0);


    signal xor_add_1 : std_logic_vector (31 downto 0);
    signal xor_add_2 : std_logic_vector (31 downto 0);
    signal xor_add_3 : std_logic_vector (31 downto 0);
    signal xor_add_4 : std_logic_vector (31 downto 0);

    signal fi : std_logic_vector (31 downto 0) := x"9e3779b9";
begin
    in_key_0 <= in_data(255 downto 128);        --ostatni klucz rundowy
    in_key_1 <= in_data(127 downto 0);          --przedostatni klucz rundowy

    s3_key: entity work.serpent_sub_key_3_fun_inv port map(in_key_0, w_from_key_0);     --slowa w wyznaczone z ostatniego klucza rundowego
    s4_key: entity work.serpent_sub_key_4_fun_inv port map(in_key_1, w_from_key_1);     --slowa w wyznaczone z przedostatniego klucza rundowego


    xor_add_1 <= x"0000" & std_logic_vector(135-4*unsigned(in_round_number));           --wartosci "i" uzywane do wyznaczania kolejnych wartosci slow w
    xor_add_2 <= x"0000" & std_logic_vector(134-4*unsigned(in_round_number));
    xor_add_3 <= x"0000" & std_logic_vector(133-4*unsigned(in_round_number));
    xor_add_4 <= x"0000" & std_logic_vector(132-4*unsigned(in_round_number));


    --wyznacznie kolejnych (w zasadzie poprzednuich) slow w, ktore sluza do wyznaczenia kolejnego (poprzedniego) klucza rundowego
    tmp_1 <= (w(7)(10 downto 0) & w(7)(31 downto 11)) xor w(2) xor w(4) xor w(6) xor fi xor xor_add_1;  

    tmp_2 <= (w(6)(10 downto 0) & w(6)(31 downto 11)) xor w(1) xor w(3) xor w(5) xor fi xor xor_add_2;

    tmp_3 <= (w(5)(10 downto 0) & w(5)(31 downto 11)) xor w(0) xor w(2) xor w(4) xor fi xor xor_add_3;

    tmp_4 <= (w(4)(10 downto 0) & w(4)(31 downto 11)) xor tmp_1 xor w(1) xor w(3) xor fi xor xor_add_4;


    --konkatenacja tych slow
    tmp_con <= tmp_4 & tmp_3 & tmp_2 & tmp_1;

    --przepuszczenie konkatenacji slow przez sboxy
    s0: entity work.serpent_sub_key_0_fun port map(tmp_con, out_s0);
    s1: entity work.serpent_sub_key_1_fun port map(tmp_con, out_s1);
    s2: entity work.serpent_sub_key_2_fun port map(tmp_con, out_s2);
    s3: entity work.serpent_sub_key_3_fun port map(tmp_con, out_s3);
    s4: entity work.serpent_sub_key_4_fun port map(tmp_con, out_s4);
    s5: entity work.serpent_sub_key_5_fun port map(tmp_con, out_s5);
    s6: entity work.serpent_sub_key_6_fun port map(tmp_con, out_s6);
    s7: entity work.serpent_sub_key_7_fun port map(tmp_con, out_s7);

    process(in_clk)
    begin
        if (rising_edge(in_clk)) then
            if(in_round_number=x"00") then
                --uzupelnienie tablicy w wartosciami w z ostanich kluczy rundowych w zerowej rundzie
                w(7) <= w_from_key_0(31 downto 0);    
                w(6) <= w_from_key_0(63 downto 32);     
                w(5) <= w_from_key_0(95 downto 64);     
                w(4) <= w_from_key_0(127 downto 96);      
                w(3) <=w_from_key_1(31 downto 0);     
                w(2) <=w_from_key_1(63 downto 32);     
                w(1) <=w_from_key_1(95 downto 64); 
                w(0) <=w_from_key_1(127 downto 96);
            end if;
            if(in_round_number/=x"00") then
                --w pozostalych rundach rotacjia tablicy w, oraz dodanie nowowyznaczonych slow
                w(7) <= w(3);
                w(6) <= w(2);
                w(5) <= w(1);
                w(4) <= w(0);
                w(3) <=tmp_1;
                w(2) <=tmp_2;
                w(1) <=tmp_3;
                w(0) <=tmp_4;
            end if;
        end if;
    end process;

    --wypisanie na magistrale wyjsciowa wyjscia z odpowiedniego sboxa
    out_key <= out_s4 when (in_round_number=x"20" or in_round_number=x"08" or in_round_number=x"10" or in_round_number=x"18")
            else out_s5 when (in_round_number=x"01" or in_round_number=x"09" or in_round_number=x"11" or in_round_number=x"19" or in_round_number=x"21") 
            else out_s6 when (in_round_number=x"02" or in_round_number=x"0a" or in_round_number=x"12" or in_round_number=x"1a") 
            else out_s7 when (in_round_number=x"03" or in_round_number=x"0b" or in_round_number=x"13" or in_round_number=x"1b") 
            else out_s0 when (in_round_number=x"04" or in_round_number=x"0c" or in_round_number=x"14" or in_round_number=x"1c") 
            else out_s1 when (in_round_number=x"05" or in_round_number=x"0d" or in_round_number=x"15" or in_round_number=x"1d") 
            else out_s2 when (in_round_number=x"06" or in_round_number=x"0e" or in_round_number=x"16" or in_round_number=x"1e") 
            else out_s3 when (in_round_number=x"07" or in_round_number=x"0f" or in_round_number=x"17" or in_round_number=x"1f") 
            else in_key_0 when (in_round_number=x"00")
            else out_s4;

    out_key_2 <= in_key_1;     


end behaviour;