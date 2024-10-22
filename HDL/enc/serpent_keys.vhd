----------------
--Jakub Zaroda--
----------------

--modul wyznaczajacy kolejne klucze rundowe
--modul wyznacza kolejne klucze rundowe na podstawie klucza glownego

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

USE work.w_array_pkg.all;

entity serpent_keys is port(
    in_clk       : in std_logic;                                --wejscie sygnalu zegarowego
    in_data      : in  std_logic_vector (255 downto 0);         --magistrala wejsciowa klucza glownego
    in_round_number : in std_logic_vector(7 downto 0);          --magistrala wejsciowa numeru rundy
    out_key      : out std_logic_vector (127 downto 0);         --magistrala wyjsciowa klucza rundowego
    out_key_2      : out std_logic_vector (127 downto 0)        --magistrala wyjsciowa drugiego klucza rundowego (uzywana podczas ostatniej rundy)
);
end serpent_keys;

architecture behaviour of serpent_keys is
    --rejestry pomocnicze
    signal w_8 : std_logic_vector (31 downto 0);
    signal w_7 : std_logic_vector (31 downto 0);
    signal w_6 : std_logic_vector (31 downto 0);
    signal w_5 : std_logic_vector (31 downto 0);
    signal w_4 : std_logic_vector (31 downto 0);
    signal w_3 : std_logic_vector (31 downto 0);
    signal w_2 : std_logic_vector (31 downto 0);
    signal w_1 : std_logic_vector (31 downto 0);

    --8 elementowa tablica przechowujaca slowa w potrzebne do wyznaczenia kluczy rundwywch
    signal w : w_array;

    signal tmp_4 : std_logic_vector (31 downto 0);
    signal tmp_3 : std_logic_vector (31 downto 0);
    signal tmp_2 : std_logic_vector (31 downto 0);
    signal tmp_1 : std_logic_vector (31 downto 0);

    signal tmp_last_4 : std_logic_vector (31 downto 0);
    signal tmp_last_3 : std_logic_vector (31 downto 0);
    signal tmp_last_2 : std_logic_vector (31 downto 0);
    signal tmp_last_1 : std_logic_vector (31 downto 0);



    signal tmp_4_rot : std_logic_vector (31 downto 0);
    signal tmp_3_rot : std_logic_vector (31 downto 0);
    signal tmp_2_rot : std_logic_vector (31 downto 0);
    signal tmp_1_rot : std_logic_vector (31 downto 0);


    signal tmp_last_4_rot : std_logic_vector (31 downto 0);
    signal tmp_last_3_rot : std_logic_vector (31 downto 0);
    signal tmp_last_2_rot : std_logic_vector (31 downto 0);
    signal tmp_last_1_rot : std_logic_vector (31 downto 0);



    signal tmp_con : std_logic_vector (127 downto 0);

    signal tmp_last_con : std_logic_vector (127 downto 0);

    signal out_s0 : std_logic_vector (127 downto 0);
    signal out_s1 : std_logic_vector (127 downto 0);
    signal out_s2 : std_logic_vector (127 downto 0);
    signal out_s3 : std_logic_vector (127 downto 0);
    signal out_s4 : std_logic_vector (127 downto 0);
    signal out_s5 : std_logic_vector (127 downto 0);
    signal out_s6 : std_logic_vector (127 downto 0);
    signal out_s7 : std_logic_vector (127 downto 0);

    signal xor_add_1 : std_logic_vector (31 downto 0);
    signal xor_add_2 : std_logic_vector (31 downto 0);
    signal xor_add_3 : std_logic_vector (31 downto 0);
    signal xor_add_4 : std_logic_vector (31 downto 0);

    signal fi : std_logic_vector (31 downto 0) := x"9e3779b9";
begin
    --wartosci "i" uzywane do wyznaczania kolejnych wartosci slow w
    xor_add_1 <= x"0000" & std_logic_vector(4*unsigned(in_round_number));
    xor_add_2 <= x"0000" & std_logic_vector(4*unsigned(in_round_number)+1);
    xor_add_3 <= x"0000" & std_logic_vector(4*unsigned(in_round_number)+2);
    xor_add_4 <= x"0000" & std_logic_vector(4*unsigned(in_round_number)+3);

    --wczytanie slow z klucza glownego w odpowiedni sposob
    w_1 <= in_data(7 downto 0) & in_data(15 downto 8) & in_data(23 downto 16) & in_data(31 downto 24);
    w_2 <= in_data(39 downto 32) & in_data(47 downto 40) & in_data(55 downto 48) & in_data(63 downto 56) ;
    w_3 <= in_data(71 downto 64) & in_data(79 downto 72) & in_data(87 downto 80) & in_data(95 downto 88) ;
    w_4 <= in_data(103 downto 96) & in_data(111 downto 104) & in_data(119 downto 112) & in_data(127 downto 120) ;
    w_5 <= in_data(135 downto 128) & in_data(143 downto 136) & in_data(151 downto 144) & in_data(159 downto 152);
    w_6 <= in_data(167 downto 160) & in_data(175 downto 168) & in_data(183 downto 176) & in_data(191 downto 184) ;
    w_7 <= in_data(199 downto 192) & in_data(207 downto 200) & in_data(215 downto 208) & in_data(223 downto 216) ;
    w_8 <= in_data(231 downto 224) & in_data(239 downto 232) & in_data(247 downto 240) & in_data(255 downto 248);


    --wyznacznie kolejnych 4 slow zgodnie z dokumnetacja
    tmp_1 <= w(7) xor w(4) xor w(2) xor w(0) xor fi xor xor_add_1 when (in_round_number/=x"00") else w_8 xor w_5 xor w_3 xor w_1 xor fi xor xor_add_1;
    tmp_1_rot <= tmp_1(20 downto 0) & tmp_1(31 downto 21);

    tmp_2 <= w(6) xor w(3) xor w(1) xor tmp_1_rot xor fi xor xor_add_2 when (in_round_number/=x"00") else w_7 xor w_4 xor w_2 xor tmp_1_rot xor fi xor xor_add_2;
    tmp_2_rot <= tmp_2(20 downto 0) & tmp_2(31 downto 21);

    tmp_3 <= w(5) xor w(2) xor w(0) xor tmp_2_rot xor fi xor xor_add_3 when (in_round_number/=x"00") else w_6 xor w_3 xor w_1 xor tmp_2_rot xor fi xor xor_add_3;
    tmp_3_rot <= tmp_3(20 downto 0) & tmp_3(31 downto 21);

    tmp_4 <= w(4) xor w(1) xor tmp_1_rot xor tmp_3_rot xor fi xor xor_add_4 when (in_round_number/=x"00") else w_5 xor w_2 xor tmp_1_rot xor tmp_3_rot xor fi xor xor_add_4;
    tmp_4_rot <= tmp_4(20 downto 0) & tmp_4(31 downto 21);

    --konkatenacja wyznaczonych slow
    tmp_con <= tmp_1_rot & tmp_2_rot & tmp_3_rot & tmp_4_rot;
    
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
                --uzupelnienie tablicy w wartosciami 'w' w zerowej rundzie
                w(7) <= w_4;
                w(6) <= w_3;
                w(5) <= w_2;
                w(4) <= w_1;
                w(3) <=tmp_1_rot;
                w(2) <=tmp_2_rot;
                w(1) <=tmp_3_rot;
                w(0) <=tmp_4_rot;
            end if;
            if(in_round_number/=x"00") then
                --w pozostalych rundach rotacja tablicy w, oraz dodanie nowowyznaczonych slow
                w(7) <= w(3);
                w(6) <= w(2);
                w(5) <= w(1);
                w(4) <= w(0);
                w(3) <=tmp_1_rot;
                w(2) <=tmp_2_rot;
                w(1) <=tmp_3_rot;
                w(0) <=tmp_4_rot;
            end if;
        end if;
    end process;

    --wypisanie na magistrale wyjsciowa wyjscia z odpowiedniego sboxa
    out_key <= out_s3 when (in_round_number=x"20" or in_round_number=x"08" or in_round_number=x"10" or in_round_number=x"18")
            else out_s2 when (in_round_number=x"01" or in_round_number=x"09" or in_round_number=x"11" or in_round_number=x"19" or in_round_number=x"21") 
            else out_s1 when (in_round_number=x"02" or in_round_number=x"0a" or in_round_number=x"12" or in_round_number=x"1a") 
            else out_s0 when (in_round_number=x"03" or in_round_number=x"0b" or in_round_number=x"13" or in_round_number=x"1b") 
            else out_s7 when (in_round_number=x"04" or in_round_number=x"0c" or in_round_number=x"14" or in_round_number=x"1c") 
            else out_s6 when (in_round_number=x"05" or in_round_number=x"0d" or in_round_number=x"15" or in_round_number=x"1d") 
            else out_s5 when (in_round_number=x"06" or in_round_number=x"0e" or in_round_number=x"16" or in_round_number=x"1e") 
            else out_s4 when (in_round_number=x"07" or in_round_number=x"0f" or in_round_number=x"17" or in_round_number=x"1f") 
            else out_s3;


    --wyznaczanie ostatniego klucza dla ostatniej rundy analogicznie jak wczesniej
    tmp_last_1 <= w(3) xor w(0) xor tmp_2_rot xor tmp_4_rot xor fi xor x"00000080" when (in_round_number=x"1F") else x"00000000";
    tmp_last_1_rot <= tmp_last_1(20 downto 0) & tmp_last_1(31 downto 21);

    tmp_last_2 <= w(2) xor tmp_1_rot xor tmp_3_rot xor tmp_last_1_rot xor fi xor x"00000081" when (in_round_number=x"1F") else x"00000000";
    tmp_last_2_rot <= tmp_last_2(20 downto 0) & tmp_last_2(31 downto 21);

    tmp_last_3 <= w(1) xor tmp_2_rot xor tmp_4_rot xor tmp_last_2_rot xor fi xor x"00000082" when (in_round_number=x"1F") else x"00000000";
    tmp_last_3_rot <= tmp_last_3(20 downto 0) & tmp_last_3(31 downto 21);

    tmp_last_4 <= w(0) xor tmp_3_rot xor tmp_last_1_rot xor tmp_last_3_rot xor fi xor x"00000083" when (in_round_number=x"1F") else x"00000000";
    tmp_last_4_rot <= tmp_last_4(20 downto 0) & tmp_last_4(31 downto 21);

    tmp_last_con <= tmp_last_1_rot & tmp_last_2_rot & tmp_last_3_rot & tmp_last_4_rot;

    slast: entity work.serpent_sub_key_3_fun port map(tmp_last_con, out_key_2);
    

end behaviour;